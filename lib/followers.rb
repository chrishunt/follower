require './lib/twitter_client'

module Followers
  extend self

  def for(username)
    TwitterClient.followers(username)
  end

  def identify(ids)
    TwitterClient.users_lookup(ids)
  end
end
