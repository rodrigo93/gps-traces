class Trace < ApplicationRecord
  attr_accessor :coordinates

  validate :check_coordinates

  def parsed
    JSON.parse(self.coordinates)
  end

  private

  def check_coordinates
    parsed.each do |coordinates|
      coordinates.deep_symbolize_keys!
      raise StandardError if Coordinate.new(coordinates).invalid?
    end
  rescue StandardError
    self.errors.add(:coordinates, 'The JSON must be well formatted and all latitudes and longitudes must be present')
  end
end
