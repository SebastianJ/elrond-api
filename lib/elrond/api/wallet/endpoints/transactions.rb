module Elrond
  module Api
    module Wallet
      module Endpoints
        module Transactions
          
          def request_tokens(address, options: {})
            response    =   post("/transaction/send-user-funds", data: {receiver: address}, options: options)&.body
          end

        end
      end
    end
  end
end
