require 'typhoeus'

module RequestBuilders
  module Runtastic
    class Request
      attr_reader :method, :url, :body

      def initialize(method, url)
        @method = method
        @url = url
      end

      def use_body(content)
        @body = content
      end

      def run
        freeze # prevents any changes to request instance once it has been made.

        raw_response = ::Typhoeus::Request.new(url, build_options).run

        ::RequestBuilders::Runtastic::Response.new(raw_response: raw_response, request: self)
      end

      private

      def build_options
        {method: method, headers: default_headers}.tap do |options|
          options[:body] = parse_body(body) if body.present?
        end
      end

      def default_headers
        {'Accept' => 'application/json;',
         'Content-Type' => 'application/json'}
      end

      def parse_body(content)
        reject_blank_fields(content).to_json
      end

      def reject_blank_fields(params)
        params.reject { |_key, value| value.nil? }
      end
    end
  end
end
