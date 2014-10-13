require "spec_helper"
require "modo_payments/api"

describe ModoPayments do
  describe "#configure" do
    before do
      ModoPayments::API.configure do |config|
        config.api_key = ENV['MODO_API_KEY']
        config.api_secret = ENV['MODO_API_SECRET']
      end
    end

    it 'should have a properly configured oauth api key and secret' do
      expect(ModoPayments::API.configuration.api_key).not_to be_empty
      expect(ModoPayments::API.configuration.api_secret).not_to be_empty
    end

    it 'should login with configured credentials' do
      client = ModoPayments::API::Client.new
      expect(client.login).to eq(true)
    end

    it 'should fail loggingin with bad credentials' do
      client = ModoPayments::API::Client.new
      expect(client.login("x","x")).to eq(false)
    end

    it 'should get a list of enabled merchants' do
      client = ModoPayments::API::Client.new
      client.merchant_list
    end

  end
end