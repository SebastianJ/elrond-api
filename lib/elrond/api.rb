require "faraday"
require "faraday_middleware"

require "logger"

require "elrond/api/version"
require "elrond/api/configuration"

require "elrond/api/endpoints/node"

require "elrond/api/client"

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
