module RequestBuilders
  module Runtastic
    class Base
      RUNTASTIC_BASE_URL = 'https://codingcontest.runtastic.com/api/'.freeze

      def build_request_for(method, url)
        ::RequestBuilders::Runtastic::Request.new(method.to_sym, url)
      end

      def build
        raise NotImplementedError, 'This method must be overwritten by the heiress class'
      end

      def run
        build.run
      end

      protected

      attr_reader :base_url

      def request_url
        "#{RUNTASTIC_BASE_URL}#{self.class::SELF_ENDPOINT_URI}"
      end
    end
  end
end
