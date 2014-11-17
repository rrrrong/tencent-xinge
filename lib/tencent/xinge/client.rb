module Tencent
  module Xinge    
    class Client

    	HOST = 'openapi.xg.qq.com'    	
    	DEFAULT_OPTIONS = {
        use_ssl: false,
        api_version: 'v2'
      }

      attr_reader :access_id, :secret_key, :api_url

      def initialize(access_id, secret_key, options = {})
        @access_id, @secret_key = (access_id || '').strip, (secret_key || '').strip
        @options = DEFAULT_OPTIONS.merge options

        # set_api_url
        @resource ||= DEFAULT_RESOURCE
        @request = Request.new(self)
      end

    	def push_single_device(device_token, message_type, message, params = {})
        type = 'push'
        method = 'single_device'
        set_api_url(type, method)
    		params.merge!({
          device_token: device_token,
          message: message.to_json,
          message_type: message_type
        	})
        @request.fetch(params)
    	end

    	def push_single_account(account, message_type, message, params = {})
        type = 'push'
        method = 'single_account'
        set_api_url(type, method)
    		params.merge!({
    			account: account,
    			message_type: message_type,
    			message: message.to_json
    			})
        @request.fetch(params)
    	end

    	def push_all_device(message_type, message, params = {})
        type = 'push'
        method = 'all_device'
        set_api_url(type, method)
    		params.merge!({
    			message_type: message_type,
    			message: message.to_json
    			})
        @request.fetch(params)
    	end

      private
      def set_api_url(type, method)
        scheme = @options[:use_ssl] ? 'https' : 'http'
        @api_url = "#{scheme}://#{HOST}/#{@options[:api_version]}/#{type}/#{method}"
      end
    end
  end
end