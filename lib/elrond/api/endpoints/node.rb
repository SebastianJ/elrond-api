module Elrond
  module Api
    module Endpoints
      module Node
        
        def address(options: {})
          get("/node/address", options: options)&.body&.fetch("address", nil)
        end
        
        def heartbeat(options: {})
          get("/node/heartbeatstatus", options: options)&.body&.fetch("message", [])
        end
        
        def start(options: {})
          get("/node/start", options: options)&.body&.fetch("message", nil)
        end
        
        def statistics(options: {})
          get("/node/statistics", options: options)&.body&.fetch("statistics", {})
        end
        
        def status(options: {})
          get("/node/status", options: options)&.body
        end
        
        def stop(options: {})
          get("/node/stop", options: options)&.body&.fetch("message", nil)
        end
        
      end
    end
  end
end
