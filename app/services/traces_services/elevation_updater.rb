module TracesServices
  class ElevationUpdater
    def initialize(trace)
      @trace = trace
      @new_coordinates ||= trace.coordinates_as_hash
      @elevation_service ||= RequestBuilders::Runtastic::Elevations::BulkCoordinate.new(@new_coordinates)
    end

    def call
      calculate_coordinates_distances
      update_trace
    end

    private

    attr_accessor :trace, :new_coordinates, :elevation_service, :elevations

    # TODO: Handle when the response fails
    def elevations
      @elevations ||= elevation_service.run.result_as_array_of_integer
    end

    def calculate_coordinates_distances
      new_coordinates.each_with_index do |_coordinate, index|
        new_coordinates[index][:elevation] = elevations[index]
      end
    end

    def update_trace
      @trace.coordinates = new_coordinates.to_json
    end
  end
end
