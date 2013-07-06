module Followers
  module TwitterClient
    extend self

    def follower_ids_for(username)
      request = Net::HTTP::Get.new(followers_uri_for username)

      request.add_field 'Authorization', "Bearer #{bearer_token}"

      JSON.parse(
        http(followers_uri_for username).request(request).body
      )['ids']
    end

    def users_for(ids)
      users = []
      # must request users in batches of 100
      until (batch = ids.slice!(0..99)).empty?
        request = Net::HTTP::Get.new(users_lookup_uri_for batch)
        request.add_field 'Authorization', "Bearer #{bearer_token}"

        users << JSON.parse(
          http(users_lookup_uri_for batch).request(request).body
        )
      end
      users.flatten
    end

    def url
      'https://twitter.com'
    end

    private

    def bearer_token
      @bearer_token ||= JSON.parse(authorization).fetch('access_token')
    end

    def authorization
      request = Net::HTTP::Post.new(auth_uri)

      request.add_field 'Authorization',
        "Basic #{bearer_token_credentials}"
      request.add_field 'Content-Type',
        'application/x-www-form-urlencoded;charset=UTF-8'

      request.set_form_data 'grant_type' => 'client_credentials'

      http(auth_uri).request(request).body
    end

    def bearer_token_credentials
      Base64.strict_encode64(
        "#{URI::encode(consumer_key)}:#{URI::encode(consumer_secret)}"
      )
    end

    def http(uri)
      Net::HTTP.new(uri.host, uri.port).tap { |http| http.use_ssl = true }
    end

    def auth_uri
      URI.parse "#{api_url}/oauth2/token"
    end

    def followers_uri_for(username)
      URI.parse "#{api_url}/1.1/followers/ids.json?screen_name=#{username}"
    end

    def users_lookup_uri_for(ids)
      URI.parse "#{api_url}/1.1/users/lookup.json?user_id=#{ids.join(',')}"
    end

    def api_url
      'https://api.twitter.com'
    end

    def consumer_key
      CONFIG.twitter_consumer_key
    end

    def consumer_secret
      CONFIG.twitter_consumer_secret
    end
  end
end
