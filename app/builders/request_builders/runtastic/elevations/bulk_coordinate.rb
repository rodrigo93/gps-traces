module RequestBuilders
  module Runtastic
    module Elevations
      class BulkCoordinate < RequestBuilders::Runtastic::Base
        SELF_ENDPOINT_URI = 'elevations/bulk'.freeze

        def initialize(coordinates)
          @coordinates = coordinates
        end

        def build
          build_request_for(:post, request_url).tap do |request|
            request.use_body(coordinates)
          end
        end

        private

        attr_accessor :coordinates
      end
    end
  end
end
