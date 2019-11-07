module Elrond
  module Api
    module Node
      module Endpoints
        module Nodes
        
          def address(options: {})
            response    =   get("/node/address", options: options)&.body
            response    =   response.fetch("address", nil) if response && response.is_a?(Hash)
          end
        
          def heartbeat(options: {})
            response    =   get("/node/heartbeatstatus", options: options)&.body
            response    =   response.fetch("message", []) if response && response.is_a?(Hash)
          end
        
          def start(options: {})
            response    =   get("/node/start", options: options)&.body
            response    =   response.fetch("message", nil) if response && response.is_a?(Hash)
          end
        
          def statistics(options: {})
            response    =   get("/node/statistics", options: options)&.body
            response    =   response.fetch("statistics", {}) if response && response.is_a?(Hash)
          end
        
          def status(options: {})
            response    =   get("/node/status", options: options)&.body
            response    =   response.fetch("details", {}) if response && response.is_a?(Hash)
          end
        
          def stop(options: {})
            response    =   get("/node/stop", options: options)&.body
            response    =   response.fetch("message", nil) if response && response.is_a?(Hash)
          end
        
        end
      end
    end
  end
end
