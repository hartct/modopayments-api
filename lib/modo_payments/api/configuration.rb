module ModoPayments
  class Configuration
    attr_accessor :api_key, :api_secret, :test_mode, :modo_base_url

    def modo_url
      "https://demo.modopayments.com/YiiModo/api_v2"
    end
  end
end