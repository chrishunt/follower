require 'followers/twitter_client'
require 'json'

describe Followers::TwitterClient do
  subject { Followers::TwitterClient }

  let(:http_client) { stub }

  before do
    stub_const('CONFIG', stub(api: 'twitter.com'))
    stub_const('HttpClient', stub(new: http_client))
  end

  describe '.followers' do
    let(:endpoint) { '/followers/ids.json' }

    it 'returns the set of follower ids' do
      http_client.should_receive(:get).
        with(endpoint, screen_name: 'chrishunt').
        and_return(stub(body: '{"ids":[1, 2, 3]}'))

      subject.followers('chrishunt').should == [1, 2, 3]
    end
  end

  describe '.users_lookup' do
    let(:endpoint) { '/users/lookup.json' }

    it 'returns the set of follower user objects' do
      ids = [1, 2, 3]

      http_client.should_receive(:get).
        with(endpoint, user_id: ids.join(',')).
        and_return(stub(body: '[{"screen_name":"chrishunt"}]'))


      subject.users_lookup(ids).should == [{ 'screen_name' => 'chrishunt' }]
    end

    it 'requests users in batches of 100' do
      ids = Array.new(150) { |i| i }

      http_client.should_receive(:get).
        with(endpoint, user_id: ids[0..99].join(',')).
        and_return(stub(body: '{}'))

      http_client.should_receive(:get).
        with(endpoint, user_id: ids[100..-1].join(',')).
        and_return(stub(body: '{}'))

      subject.users_lookup(ids)
    end
  end
end
