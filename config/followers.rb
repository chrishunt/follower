CONFIG = OpenStruct.new(
  username: ENV['TWITTER_USERNAME'],
  consumer_key: ENV['TWITTER_CONSUMER_KEY'],
  consumer_secret: ENV['TWITTER_CONSUMER_SECRET'],

  deliver_email: ENV['FOLLOWERS_DELIVERY_EMAIL'],
  gmail_username: ENV['FOLLOWERS_GMAIL_USERNAME'],
  gmail_password: ENV['FOLLOWERS_GMAIL_PASSWORD'],

  database: URI.parse(ENV['DATABASE_URL']),

  log: STDOUT
).freeze
