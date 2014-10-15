module ModoPayments
  class Configuration
    attr_accessor :api_key, :api_secret, :test_mode, :modo_base_url, :access_token_timeout_seconds

    def initialize

    end

    def modo_url
      "https://demo.modopayments.com/YiiModo/api_v2"
    end
  end
end