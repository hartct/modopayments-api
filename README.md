# modopayments-api

This gem provides a light-weight wrapper around the ModoPayments APIs.

## Installation

Add this line to your application's Gemfile:

    gem 'modo_payments-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install modo_payments-api

## Important Warning

The nature of the ModoPayments API involves financial transactions. This wrapper does not provide for validation
or sanity checking. Please make sure you have appropriately tested before using this in production!

## Usage

The gem must be configured minimally with your ModoPayments assigned API key and secret. This can be done in an
initializer like this:

```
ModoPayments::API.configure do |config|
  config.api_key = "YOUR_KEY"
  config.api_secret = "YOUR_SECRET"
end
```

By default, the gem is configured to invoke requests to the *demo* v2 ModoPayments APIs. You can change this by
configuring the modo_base_url:

```
ModoPayments::API.configuration.modo_base_url="https://other.url.com"
```

### Using the client

In general, this gem uses hashes to pass values to the ModoPayments API using their native key names. Use of the client
requires knowledge of how the underlying ModoPayments API works.

Get an instance of the ModoPayments API client like this:

`client = ModoPayments::API::Client.new`

Retrieve a merchant list:

`response = client.merchant_list`

Register a person:

`response = client.register_person({"phone" => "9802531234"})`

Get a person's profile:

`response = client.get_person(account_id)`

Add a card:
```
response = client.add_card({"account_id" => account_id, "card_number" => "5153648888888880",
                              "expiry" => "1220", "zip_code" => "28210"})
```

Send a gift:
```
response = client.send_gift({"account_id" => account_id, "gift_amount" => 50.00, "receiver_phone" => "9802531234",
                               "gift_details_url" => "http://test.com"})
```
## Contributing

1. Fork it ( https://github.com/hartct/modopayments-api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Testing

The RSpec tests for this gem rely on API keys and secrets to be passed in as environment variables. Set your API
key and secret using the MODO_API_KEY and MODO_API_SECRET environment variables.