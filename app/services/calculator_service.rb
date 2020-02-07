class CalculatorService
  class << self
    EARTH_RADIUS_KM = 6371
    EARTH_RADIUS_METERS = (EARTH_RADIUS_KM * 1000)

    RADIUS_PER_DEGREE = (Math::PI / 180)

    # Calculates distance in meters between two coordinates.
    # It uses the Haversine Formula.
    # https://en.wikipedia.org/wiki/Haversine_formula
    # https://www.igismap.com/haversine-formula-calculate-geographic-distance-earth/
    #
    # rubocop:disable Metrics/AbcSize
    def distance_between_coordinates(latitude1, longitude1, latitude2, longitude2)
      d_latitude = to_radians(latitude2 - latitude1)
      d_longitude = to_radians(longitude2 - longitude1)

      radian_latitude1 = to_radians(latitude1)
      radian_latitude2 = to_radians(latitude2)

      a = Math.sin(d_latitude / 2)**2 +
          Math.cos(radian_latitude1) *
          Math.cos(radian_latitude2) *
          Math.sin(d_longitude / 2)**2

      c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

      EARTH_RADIUS_METERS * c
    end
    # rubocop:enable Metrics/AbcSize

    def to_radians(value)
      value.to_f * RADIUS_PER_DEGREE
    end
  end
end
