class Trace < ApplicationRecord

  validates_presence_of :coordinates
  validate :check_coordinates

  before_save :update_distances, if: -> { changes.include?(:coordinates) }

  def coordinates_as_hash
    JSON.parse(coordinates)
  end

  private

  def check_coordinates
    coordinates_as_hash.each do |coordinates|
      coordinates.deep_symbolize_keys!
      raise StandardError if Coordinate.new(coordinates).invalid?
    end
  rescue StandardError
    errors.add(:coordinates, 'The JSON must be well formatted and all latitudes and longitudes must be present')
  end

  def update_distances
    raise NotImplementedError, 'Implement this method'
  end
end
