module RequestBuilders
  module Runtastic
    module Elevations
      class SingleCoordinate < RequestBuilders::Runtastic::Base
        SELF_ENDPOINT_URI = 'elevations'.freeze

        def initialize(latitude, longitude)
          @latitude = latitude
          @longitude = longitude
        end

        def build
          url = "#{request_url}/#{latitude}/#{longitude}"

          build_request_for(:get, url)
        end

        private

        attr_accessor :latitude, :longitude
      end
    end
  end
end
