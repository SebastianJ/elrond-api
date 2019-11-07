module Elrond
  module Api
    module Wallet
      module Endpoints
        module Address
          
          def address(address, options: {})
            data          =   nil
            response      =   get("/address/#{address}", options: options)&.body
            
            if response && response.is_a?(Hash)
              response    =   response&.fetch("account", {})
              nonce       =   response.fetch("nonce", nil)
              balance     =   response.fetch("balance", nil)
              balance     =   !balance.to_s.empty? ? (balance.to_f / 10_000.0) : nil
              
              data        =   {
                address: address,
                nonce:   nonce,
                balance: balance
              }
            end
            
            return data            
          end

        end
      end
    end
  end
end
