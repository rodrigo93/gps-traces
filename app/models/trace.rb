class Trace < ApplicationRecord

  validates_presence_of :coordinates
  validate :check_coordinates

  before_save :update_distances, if: -> { changes.include?(:coordinates) }

  def coordinates_as_hash
    JSON.parse(coordinates)&.each(&:deep_symbolize_keys!)
  end

  def distances_calculated?
    calculated_metric?(:distance)
  end

  def elevations_calculated?
    calculated_metric?(:elevation)
  end

  def update_distances
    TracesServices::DistanceUpdater.new(self).call
  end

  def update_distances!
    update_distances
    save!
    reload
  end

  private

  def calculated_metric?(metric_key)
    coordinates_as_hash.all? { |coordinate| coordinate.key?(metric_key.to_sym) }
  end

  def check_coordinates
    coordinates_as_hash.each do |coordinate|
      raise StandardError if Coordinate.new(latitude: coordinate[:latitude], longitude: coordinate[:longitude]).invalid?
    end
  rescue StandardError
    errors.add(:coordinates, 'The JSON must be well formatted and all latitudes and longitudes must be present')
  end
end
