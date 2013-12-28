CONFIG = OpenStruct.new(
  twitter_username: ENV['TWITTER_USERNAME'],
  twitter_consumer_key: ENV['TWITTER_CONSUMER_KEY'],
  twitter_consumer_secret: ENV['TWITTER_CONSUMER_SECRET'],

  to_email_address: ENV['FOLLOWERS_TO_EMAIL_ADDRESS'],
  from_email_address: ENV['FOLLOWERS_FROM_EMAIL_ADDRESS'],

  smtp_address: ENV['FOLLOWERS_SMTP_ADDRESS'],
  smtp_port: ENV['FOLLOWERS_SMTP_PORT'],
  smtp_username: ENV['FOLLOWERS_SMTP_USERNAME'],
  smtp_password: ENV['FOLLOWERS_SMTP_PASSWORD'],

  database: URI.parse(
    if ENV['DATABASE_URL'].to_s.empty?
      ENV['BOXEN_POSTGRESQL_URL'].to_s
    else
      ENV['DATABASE_URL'].to_s
  end),

  log: STDOUT
).freeze
