module TracesServices
  class DistanceUpdater
    def initialize(trace)
      @trace = trace
      @new_coordinates ||= trace.coordinates_as_hash
      @distance_calculator ||= CoordinatesCalculator
    end

    def call
      calculate_coordinates_distances
      update_trace
    end

    private

    attr_accessor :trace, :new_coordinates, :distance_calculator

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def calculate_coordinates_distances
      new_coordinates.each_with_index do |coordinate, index|
        if index.zero?
          new_coordinates[index][:distance] = 0
          next
        end

        previous_coordinate = new_coordinates[index - 1]
        distance = distance_calculator.distance_between_coordinates(previous_coordinate[:latitude],
                                                                    previous_coordinate[:longitude],
                                                                    coordinate[:latitude],
                                                                    coordinate[:longitude])

        new_coordinates[index][:distance] = (distance + previous_coordinate[:distance]).ceil
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    def update_trace
      @trace.coordinates = new_coordinates.to_json
    end
  end
end
