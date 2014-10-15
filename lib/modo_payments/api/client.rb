require "base64"
require 'net/http'
require 'json'

module ModoPayments
  module API

    class Client
      @access_token = nil
      @access_token_created_at = nil

      def initialize(token=nil, created_at=nil)
        @access_token = token
        @access_token_created_at = created_at || Time.now
      end

      def login(key=ModoPayments::API.configuration.api_key, secret=ModoPayments::API.configuration.api_secret)
        encoded_credential = Base64.strict_encode64 "#{key}:#{secret}"
        uri = URI.parse("#{ModoPayments::API.configuration.modo_url}/token?credentials=#{encoded_credential}")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        response = Net::HTTP.post_form(uri, 'credentials' => encoded_credential)
        response_json = JSON.parse(response.body)
        if response_json["status_code"] == 0
          @access_token = response_json["response_data"]["access_token"]
          @access_token_created_at = Time.now
          true
        else
          false
        end
      end

      def merchant_list
        uri = URI.parse("#{ModoPayments::API.configuration.modo_url}/merchant/list")
        response_json = post_with_access_token(uri)
        response_json
      end

      def register_person(params={})
        uri = URI.parse("#{ModoPayments::API.configuration.modo_url}/people/register")
        response_json = post_with_access_token(uri, params)
        response_json
      end

      def add_card(params={})
        uri = URI.parse("#{ModoPayments::API.configuration.modo_url}/card/add")
        response_json = post_with_access_token(uri, params)
        response_json
      end

      def send_gift(params={})
        uri = URI.parse("#{ModoPayments::API.configuration.modo_url}/gift/send")
        response_json = post_with_access_token(uri, params)
        response_json
      end

      private
      def post_with_access_token(uri, post_data={})
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        self.login if @access_token.nil? || access_token_expired?
        if @access_token && !access_token_expired?
          response = Net::HTTP.post_form(uri, post_data.merge('consumer_key' => "Modo", 'access_token' => @access_token) )
          response_json = JSON.parse(response.body)
          response_json
        else
          false
        end
      end

      def access_token_expired?
        if @access_token_created_at && ModoPayments::API.configuration.access_token_timeout_seconds &&
            (Time.now - @access_token_created_at) > access_token_timeout_seconds
          true
        else
          false
        end
      end

    end
  end
end
