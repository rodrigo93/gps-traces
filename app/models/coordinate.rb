class Coordinate
  attr_accessor :latitude, :longitude

  def initialize(latitude:, longitude:)
    @latitude = latitude
    @longitude = longitude
  end

  def invalid?
    !valid?
  end

  def valid?
    latitude.present? && longitude.present?
  end
end
