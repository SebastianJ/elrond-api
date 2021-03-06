module Elrond
  module Api
    module Wallet
      
      class Client
        attr_accessor :proxy, :user_agent, :configuration, :connection, :headers
    
        def initialize(proxy: nil, user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.87 Safari/537.36", configuration: ::Elrond::Api.configuration, options: {})
          self.proxy            =   proxy
          self.user_agent       =   user_agent
          self.configuration    =   configuration
        
          set_headers
          set_connection
        end

        def set_connection
          self.connection       =   ::Faraday.new(self.configuration.endpoints.dig(:wallet, :host)) do |builder|
            builder.options[:timeout]         =   self.configuration.faraday.fetch(:timeout, nil)      if self.configuration.faraday.fetch(:timeout, nil)
            builder.options[:open_timeout]    =   self.configuration.faraday.fetch(:open_timeout, nil) if self.configuration.faraday.fetch(:open_timeout, nil)
      
            builder.headers     =   self.headers if self.headers && !self.headers.empty?
          
            builder.request  :json
      
            builder.response :logger, ::Logger.new(STDOUT), bodies: true if self.configuration.verbose
            builder.response :json, content_type: /\bjson$/
      
            builder.use ::FaradayMiddleware::FollowRedirects, limit: 10
      
            if self.proxy
              builder.proxy     =   self.proxy
              log("Will use proxy: #{builder.proxy.inspect}")
            end
  
            builder.adapter self.configuration.faraday.fetch(:adapter, ::Faraday.default_adapter)
          end
        end
      
        def get(path, parameters: {}, headers: {}, options: {})
          request path, method: :get, parameters: parameters, headers: headers, options: options
        end

        def post(path, parameters: {}, data: {}, headers: {}, options: {})
          request path, method: :post, parameters: parameters, data: data, headers: headers, options: options
        end
      
        def put(path, parameters: {}, data: {}, headers: {}, options: {})
          request path, method: :put, parameters: parameters, data: data, headers: headers, options: options
        end
      
        def patch(path, parameters: {}, data: {}, headers: {}, options: {})
          request path, method: :patch, parameters: parameters, data: data, headers: headers, options: options
        end
      
        def delete(path, parameters: {}, data: {}, headers: {}, options: {})
          request path, method: :delete, parameters: parameters, data: data, headers: headers, options: options
        end
      
        def request(path, method: :get, parameters: {}, data: {}, headers: {}, options: {}, retries: 3)
          response                  =   nil

          response                  =   case method
            when :get
              self.connection.get do |request|
                request.url path
                request.headers     =   self.connection.headers.merge(headers)
                request.params      =   parameters if parameters && !parameters.empty?
              end
            when :head
              self.connection.head do |request|
                request.url path
                request.headers     =   self.connection.headers.merge(headers)
                request.params      =   parameters if parameters && !parameters.empty?
              end
            when :post, :put, :patch, :delete
              self.connection.send(method) do |request|
                request.url path
                request.headers     =   self.connection.headers.merge(headers)
                request.body        =   data if data && !data.empty?
                request.params      =   parameters if parameters && !parameters.empty?
              end
          end
      
          return response
        end
      
        def set_headers
          self.headers                =   self.configuration.endpoints.dig(:wallet, :headers)
          self.headers["User-Agent"]  =   self.user_agent unless self.user_agent.to_s.empty?
        end
      
        def log(tag = self.class.name, message)
          puts "[#{tag}] - #{Time.now}: #{message}" if self.configuration.verbose
        end
        
        include ::Elrond::Api::Wallet::Endpoints::Address
        include ::Elrond::Api::Wallet::Endpoints::Transactions
        
      end
    end
  end
end
