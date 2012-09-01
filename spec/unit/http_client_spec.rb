require 'http_client'

describe HttpClient do
  subject { HttpClient.new(url) }

  let(:headers) {{ 'Content-Type' => 'application/json' }}
  let(:url)     { 'http://example.com' }
  let(:http)    { stub('Net::HTTP').as_null_object }

  before do
    stub_const('Net::HTTP', stub(new: http))
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
