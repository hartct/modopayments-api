require "spec_helper"
require "modo_payments/api"

describe ModoPayments do
  describe "API tests" do
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
      response = client.merchant_list
      expect(response["response_data"].count > 0)
      expect(response["status_code"]).to eq(0)
    end

    it 'should register a person' do
      client = ModoPayments::API::Client.new
      response = client.register_person({"phone" => "9802535050"})
      expect(response["status_code"]).to eq(0)
    end

    #TODO: There is probably a better way to test this combination
    it 'should register a person and add a card' do
      client = ModoPayments::API::Client.new
      response = client.register_person({"phone" => "9802535050"})
      expect(response["status_code"]).to eq(0)
      account_id = response["response_data"]["account_id"]
      response2 = client.add_card({"account_id" => account_id, "card_number" => "5153648888888880", "expiry" => "1220", "zip_code" => "28210"})
      expect(response2["status_code"]).to eq(0)
    end

    #TODO: There is probably a better way to test this combination
    it 'should register a person, add a card and send a gift' do
      client = ModoPayments::API::Client.new
      response = client.register_person({"phone" => "9802535050"})
      expect(response["status_code"]).to eq(0)
      account_id = response["response_data"]["account_id"]
      response2 = client.add_card({"account_id" => account_id, "card_number" => "5153648888888880", "expiry" => "1220", "zip_code" => "28210"})
      expect(response2["status_code"]).to eq(0)
      response3 = client.send_gift({"account_id" => account_id, "gift_amount" => 50.00, "receiver_phone" => "9802535050"})
      p response3
      expect(response3["status_code"]).to eq(0)
    end

  end
end