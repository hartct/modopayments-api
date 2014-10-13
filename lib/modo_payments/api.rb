require "modo_payments/api/version"
require "modo_payments/api/configuration"

module ModoPayments
  module API
    class << self
      attr_writer :configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configure
      yield(configuration)
    end
  end
end
