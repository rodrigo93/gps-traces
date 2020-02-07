class Trace < ApplicationRecord

  validates_presence_of :coordinates
  validate :check_coordinates

  before_save :update_distances, if: -> { changes.include?(:coordinates) }

  def coordinates_as_hash
    JSON.parse(coordinates)&.each(&:deep_symbolize_keys!)
  end

  private

  def check_coordinates
    coordinates_as_hash.each do |coordinate|
      raise StandardError if Coordinate.new(coordinate).invalid?
    end
  rescue StandardError
    errors.add(:coordinates, 'The JSON must be well formatted and all latitudes and longitudes must be present')
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def update_distances
    new_coordinates = coordinates_as_hash

    new_coordinates.each_with_index do |coordinate, index|
      if index.zero?
        new_coordinates[index][:distance] = 0
        next
      end

      previous_coordinate = new_coordinates[index-1]
      distance = distance_calculator.distance_between_coordinates(previous_coordinate[:latitude],
                                                                  previous_coordinate[:longitude],
                                                                  coordinate[:latitude],
                                                                  coordinate[:longitude])

      new_coordinates[index][:distance] = (distance + previous_coordinate[:distance]).ceil
    end

    self.coordinates = new_coordinates.to_json
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  def distance_calculator
    @distance_calculator ||= CalculatorService
  end
end
