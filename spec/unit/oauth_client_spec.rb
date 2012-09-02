require 'oauth_client'

describe OauthClient do
  subject { OauthClient.new(url, config) }

  let(:url)  { 'http://example.com' }
  let(:http) { stub }
  let(:headers) {{ 'Content-Type' => 'application/json' }}

  let(:config) {
    OauthClient::Config.new(
      api_token:    'apitoken',
      api_secret:   'apisecret',
      oauth_token:  'oauthtoken',
      oauth_secret: 'oauthsecret'
  )}

  before do
    stub_const('OAuth::Consumer', stub.as_null_object)
    stub_const('OAuth::AccessToken', stub.as_null_object)
    subject.stub(http: http)
  end

  describe '#get' do
    it 'makes a get request without params' do
      path = '/api'
      http.should_receive(:get).with(path, headers)

      subject.get(path)
    end

    it 'makes a get requests with params' do
      path = '/api'
      params = { :p1  => 1, :p2 => 'hello world' }
      http.should_receive(:get).with("#{path}?p1=1&p2=hello%20world", headers)

      subject.get(path, params)
    end
  end
end
