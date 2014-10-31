require 'faraday'
require 'faraday_middleware'
require 'faraday-cookie_jar'

module Spider
  module Request

    def get(url, params = {}, headers = {})
      request(:get, url, params, headers)
    end

    def post(url, params = {}, headers = {})
      request(:post, url, params, headers)
    end

    def request(method, url, params, headers)
      connection.send(method)  do |req|
        case method
        when :get
          req.url url, params
        when :post
          req.url url
          req.body = params
        end
        req.headers['User-Agent'] = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31'
        req.headers.merge!(headers)
      end
    end

    def connection
     @connection ||= Faraday.new do |faraday|
        faraday.request  :url_encoded
        faraday.response :follow_redirects
        faraday.use :cookie_jar
        faraday.response :logger if ENV['FARADAY_LOG']
        faraday.adapter  Faraday.default_adapter
      end
    end

  end
end
