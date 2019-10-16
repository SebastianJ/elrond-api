module Elrond
  module Api
    module Endpoints
      module Node
        
        def heartbeat(options: {})
          response              =   get("/node/heartbeatstatus", options: options)          
          return response&.body
        end
        
        def status(options: {})
          response              =   get("/node/status", options: options)          
          return response&.body
        end
        
      end
    end
  end
end
