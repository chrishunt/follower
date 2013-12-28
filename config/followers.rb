CONFIG = OpenStruct.new(
  twitter_username: ENV['TWITTER_USERNAME'].to_s,
  twitter_consumer_key: ENV['TWITTER_CONSUMER_KEY'].to_s,
  twitter_consumer_secret: ENV['TWITTER_CONSUMER_SECRET'].to_s,

  to_email_address: ENV['FOLLOWERS_TO_EMAIL_ADDRESS'].to_s,
  from_email_address: ENV['FOLLOWERS_FROM_EMAIL_ADDRESS'].to_s,

  smtp_address: ENV['FOLLOWERS_SMTP_ADDRESS'].to_s,
  smtp_port: ENV['FOLLOWERS_SMTP_PORT'].to_s,
  smtp_username: ENV['FOLLOWERS_SMTP_USERNAME'].to_s,
  smtp_password: ENV['FOLLOWERS_SMTP_PASSWORD'].to_s,

  database: URI.parse(
    if ENV['DATABASE_URL'].to_s.empty?
      ENV['BOXEN_POSTGRESQL_URL'].to_s
    else
      ENV['DATABASE_URL'].to_s
  end),

  log: STDOUT
).freeze
