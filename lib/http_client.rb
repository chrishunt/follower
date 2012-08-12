require 'net/http'
require 'uri'

class HttpClient
  attr_reader :host, :http

  def initialize(url, ssl = true)
    @host = URI.parse(url)
    @http = Net::HTTP.new(@host.host, @host.port).tap do |http|
      http.use_ssl = true if ssl
    end
  end

  def get(path, params = {})
    url = host.path + path + encode(params)
    http.get(url, headers)
  end

  protected

  def encode(params)
    return '' unless params.size > 0

    '?' + params.map do |k, v|
      "#{URI.encode(k.to_s)}=#{URI.encode(v.to_s)}"
    end.join('&')
  end

  def headers
    { 'Content-Type' => 'application/json' }
  end
end
