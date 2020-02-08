module RequestBuilders
  module Runtastic
    class Response
      attr_reader :request

      def initialize(raw_response:, request:)
        @raw_response = raw_response
        @request = request
      end

      def to_hash
        ::JSON.parse(result.to_s).deep_symbolize_keys
      rescue JSON::ParserError
        {}
      end

      def result
        raw_response.body
      end

      def result_as_integer
        result.to_i
      end

      def result_as_array_of_integer
        result.gsub(/\[|\]/, '').split(',').map(&:to_i)
      end

      def fail?
        !success?
      end

      def empty?
        raw_response.body.blank?
      end

      def status_code
        raw_response.code
      end

      def success?
        raw_response.success?
      end

      private

      attr_reader :raw_response
    end
  end
end
