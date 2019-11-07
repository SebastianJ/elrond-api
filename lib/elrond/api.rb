require "faraday"
require "faraday_middleware"

require "logger"

require "elrond/api/version"
require "elrond/api/configuration"

require "elrond/api/node/endpoints/nodes"
require "elrond/api/node/endpoints/address"

require "elrond/api/node/client"

require "elrond/api/wallet/endpoints/address"
require "elrond/api/wallet/endpoints/transactions"
require "elrond/api/wallet/client"

module Elrond
  module Api
    
    class << self
      attr_writer :configuration
    
      def configuration
        @configuration ||= ::Elrond::Api::Configuration.new
      end

      def reset
        @configuration = ::Elrond::Api::Configuration.new
      end

      def configure
        yield(configuration)
      end
    end
    
    class Error < StandardError; end
  end
end
