module Tencent
  module Xinge    
    class Client

    	HOST = 'openapi.xg.qq.com'    	
    	DEFAULT_OPTIONS = {
        use_ssl: false,
        api_version: 'v2'
      }

      attr_reader :access_id, :secret_key
      attr_accessor :api_url

      def initialize(access_id, secret_key, options = {})
        @access_id, @secret_key = (access_id || '').strip, (secret_key || '').strip
        @options = DEFAULT_OPTIONS.merge options
        @request = Request.new(self)
      end

      #Push消息（包括通知和透传消息）给单个设备
    	def push_single_device(device_token, message_type, message, params = {})
        type = 'push'
        method = 'single_device'
        set_api_url(type, method)
    		params.merge!({
          device_token: device_token,
          message: message,
          message_type: message_type
        	})
        @request.fetch(params)
    	end

      #Push消息（包括通知和透传消息）给单个账户或别名
    	def push_single_account(account, message_type, message, params = {})
        type = 'push'
        method = 'single_account'
        set_api_url(type, method)
    		params.merge!({
    			account: account,
    			message_type: message_type,
    			message: message
    			})
        @request.fetch(params)
    	end

      #Push消息（包括通知和透传消息）给app的所有设备
    	def push_all_device(message_type, message, params = {})
        type = 'push'
        method = 'all_device'
        set_api_url(type, method)
    		params.merge!({
    			message_type: message_type,
    			message: message
    			})
        @request.fetch(params)
    	end

      #Push消息（包括通知和透传消息）给tags指定的设备
      def push_tags_device(message_type, message, tags_list, tags_op, params = {})
        type = 'push'
        method = 'tags_device'
        set_api_url(type, method)
        params.merge!({
          message_type: message_type,
          message: message,
          tags_list: tags_list.to_json,
          tags_op: tags_op
          })
        @request.fetch(params)
      end

      #查询群发消息发送状态
      def push_get_msg_status(push_ids, params = {})
        type = 'push'
        method = 'get_msg_status'
        set_api_url(type, method)
        params.merge!({
          push_ids: push_ids.to_json
          })
        @request.fetch(params)
      end

      #查询应用覆盖的设备数
      def application_get_app_device_num(params = {})
        type = 'application'
        method = 'get_app_device_num'
        set_api_url(type, method)
        @request.fetch(params)
      end

      #查询应用的Tags
      def tags_query_app_tags(params = {})
        type = "tags"
        method = "query_app_tags"
        set_api_url(type, method)
        @request.fetch(params)
      end

      #取消尚未触发的定时群发任务
      def push_cancel_timing_task(push_id, params = {})
        type = 'push'
        method = 'cancel_timing_task'
        set_api_url(type, method)
        params.merge!({
          push_id: push_id
          })
        @request.fetch(params)
      end

      #批量设置标签
      def tags_batch_set(tag_token_list, params = {})
        type = 'tags'
        method = 'batch_set'
        set_api_url(type, method)
        params.merge!({
          tag_token_list: tag_token_list
          })
        @request.fetch(params)
      end

      #批量删除标签
      def tags_batch_del(tag_token_list, params = {})
        type = 'tags'
        method = 'batch_del'
        set_api_url(type, method)
        params.merge!({
          tag_token_list: tag_token_list
          })
        @request.fetch(params)
      end

      #查询应用某token设置的标签
      def tags_query_token_tags(device_token, params = {})
        type = 'tags'
        method = 'query_token_tags'
        set_api_url(type, method)
        params.merge!({
          device_token: device_token
          })
        @request.fetch(params)
      end

      #查询应用某标签关联的设备数量
      def tags_query_tag_token_num(tag, params = {})
        type = 'tags'
        method = 'query_tag_token_num'
        set_api_url(type, method)
        params.merge!({
          tag: tag
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