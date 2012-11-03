module Followers
  module TwitterClient
    extend self

    def followers(username)
      result = http.get('/followers/ids.json', { screen_name: username })
      JSON.parse(result.body)['ids']
    end

    def users_lookup(ids)
      users = []
      # must request users in batches of 100
      until (batch = ids.slice!(0..99)).empty?
        result = http.get('/users/lookup.json', { user_id: batch.join(',') })
        users << JSON.parse(result.body)
      end
      users.flatten
    end

    protected

    def http
      OauthClient.new(CONFIG.api, OauthClient::Config.new(
        api_token:    CONFIG.api_token,
        api_secret:   CONFIG.api_secret,
        oauth_token:  CONFIG.oauth_token,
        oauth_secret: CONFIG.oauth_secret
      ))
    end
  end
end
