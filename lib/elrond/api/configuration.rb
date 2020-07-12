module Elrond
  module Api
    class Configuration
      attr_accessor :faraday, :verbose, :endpoints
    
      def initialize
        self.endpoints    =   {
          wallet: {
            host: "https://api.elrond.com",
            headers: {
              "Host"        =>  "wallet-api.elrond.com",
              "origin"      =>  "https://explorer.elrond.com",
              "referer"     =>  "https://explorer.elrond.com/"
            }
          }
        }
        
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
