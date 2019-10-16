module Elrond
  module Api
    module Endpoints
      module Address
        
        def account(address, options: {})
          get("/address/#{address}", options: options)&.body&.fetch("account", {})
        end
        
        def balance(address, options: {})
          get("/address/#{address}/balance", options: options)&.body
        end
        
      end
    end
  end
end
