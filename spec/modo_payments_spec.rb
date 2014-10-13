require "spec_helper"

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
  end
end