# frozen_string_literal: true

require 'uri'
require 'openssl'
require 'net/http'

module Fountain
  module Api
    #
    # Fountain API HTTP request helper
    #
    module RequestHelper
      DEFAULT_REQUEST_OPTIONS = {
        method: :get,
        body: nil,
        headers: nil,
        ssl_verify_mode: OpenSSL::SSL::VERIFY_PEER,
        ssl_ca_file: nil
      }.freeze

      def request_json(path, options = {})
        expected_response = options.delete :expected_response
        response = request path, options
        check_response response, expected_response
        parse_response response.body
      end

      def request(path, options = {})
        options = DEFAULT_REQUEST_OPTIONS.merge(options)

        raise Fountain::InvalidMethodError unless %i[get post put delete].include? options[:method]

        http = create_http(options)
        req = create_request(path, options)
        http.start { http.request(req) }
      end

      private

      def check_response(response, expected_response = nil)
        expected_response ||= Net::HTTPOK
        case response
        when expected_response then nil
        when Net::HTTPUnauthorized then raise Fountain::AuthenticationError
        when Net::HTTPNotFound then raise Fountain::NotFoundError
        else raise HTTPError, "Invalid http response code: #{response.code}"
        end
      end

      def parse_response(response)
        JSON.parse(response)
      rescue JSON::ParserError
        raise Fountain::JsonParseError, "Fountain response parse error: #{response}"
      end

      def create_http(options)
        server = URI.parse Fountain.host_path
        http = Net::HTTP.new(server.host, server.port)

        if server.scheme == 'https'
          http.use_ssl = true
          http.verify_mode = options[:ssl_verify_mode]
          http.ca_file = options[:ssl_ca_file] if options[:ssl_ca_file]
        end

        http
      end

      def create_request(path, options)
        headers = get_headers(options)
        body = options[:body]

        case options[:method]
        when :post then create_post_request path, headers, body
        when :put then create_put_request path, headers, body
        when :delete then create_delete_request path, headers
        else create_get_request path, headers, body
        end
      end

      def create_post_request(path, headers, body)
        req = Net::HTTP::Post.new(path, headers)
        add_body(req, body) if body
        req
      end

      def create_put_request(path, headers, body)
        req = Net::HTTP::Put.new(path, headers)
        add_body(req, body) if body
        req
      end

      def create_delete_request(path, headers)
        Net::HTTP::Delete.new(path, headers)
      end

      def create_get_request(path, headers, body)
        path += '?' + body.map { |k, v| "#{k}=#{v}" }.join('&') if body
        Net::HTTP::Get.new(path, headers)
      end

      def get_headers(options)
        headers = options[:headers]
        headers ||= {}
        raise Fountain::MissingApiKeyError if Fountain.api_token.nil?

        headers['X-ACCESS-TOKEN'] = Fountain.api_token
        headers
      end

      def add_body(request, body)
        if body.is_a? Hash
          request.body = body.to_json
          request.content_type = 'application/json'
        else
          request.body = body.to_s
        end
      end
    end
  end
end
