module Elrond
  module Api
    class Configuration
      attr_accessor :faraday, :verbose
    
      def initialize
        self.faraday      =   {
          adapter:      :net_http,
          timeout:      120,
          open_timeout: 60
        }
        
        self.verbose      =   false
      end
    
    end
  end
end
