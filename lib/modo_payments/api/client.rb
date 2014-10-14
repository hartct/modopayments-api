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
      end

      private
      def post_with_access_token(uri)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        self.login if @access_token.nil?
        puts "using @access_token = #{@access_token}"
        response = Net::HTTP.post_form(uri, 'consumer_key' => "Modo", 'access_token' => @access_token)
        puts "response = #{response.body}"
        response_json = JSON.parse(response.body)
      end

      def access_token_expired?

      end
    end
  end
end
