# Wrapper for Oauth gem. Encodes params and passes in default headers.
class OauthClient
  attr_reader :host, :config, :http

  Config = Struct.new(:api_token, :api_secret, :oauth_token, :oauth_secret)

  def initialize(url, config)
    @host = URI.parse(url)
    @config = config
    @http = prepare_access_token
  end

  def get(path, params = {})
    url = path + encode(params)
    http.get(url, headers)
  end

  protected

  def prepare_access_token
    consumer = OAuth::Consumer.new(
      config.api_token, config.api_secret, site: host)

    return OAuth::AccessToken.from_hash(consumer, {
      oauth_token: config.oauth_token,
      oauth_token_secret: config.oauth_secret })
  end

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
