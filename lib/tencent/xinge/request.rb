require 'httparty'
require 'open-uri'
require 'digest'

module Tencent
	module Xinge
		class Request
			include HTTParty
			base_uri 'openapi.xg.qq.com'
			HTTP_METHOD = :post

	    attr_reader :client

	    def initialize(client)
	      @client = client
	    end

	    def fetch(params = {})
	      params.merge!({apikey: @client.api_key,
	                     timestamp: Time.now.to_i})
	      sign = generate_sign(params)
	      params.merge!({ sign: sign })

	      options = { body: params }
	      self.class.post(HTTP_METHOD, "#{@client.api_url}, options)
	    end

	    def generate_sign(sign_params)
	      params_string = sign_params.sort.map{ |h| h.join('=') }.join
	      gather = "#{HTTP_METHOD.to_s.upcase}#{@client.api_url}/#{@client.resource}#{params_string}#{@client.secret_key}"

	      Digest::MD5.hexdigest(URI::encode_www_form_component(gather))
	    end
		end
	end
end