require './lib/http_client'
require 'json'

module TwitterClient
  extend self

  TWITTER_API = 'https://api.twitter.com/1'

  def followers(username)
    result = http.get('/followers/ids.json', {
      :screen_name => username
    })
    JSON.parse(result.body)['ids']
  end

  def users_lookup(ids)
    users = []
    # must request users in batches of 100
    until (batch = ids.slice!(0..99)).empty?
      result = http.get('/users/lookup.json', {
        :user_id => batch.join(',')
      })
      users << JSON.parse(result.body)
    end
    users.flatten
  end

  protected

  def http
    @http ||= HttpClient.new(TWITTER_API)
  end
end
