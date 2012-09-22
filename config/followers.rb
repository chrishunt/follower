CONFIG = OpenStruct.new(
  username:   'chrishunt',

  url:        'https://twitter.com',
  api:        'https://api.twitter.com/1',
  api_token:  '',
  api_secret: '',

  oauth_token:  '',
  oauth_secret: '',

  deliver_email:  ENV['FOLLOWERS_DELIVERY_EMAIL'],
  gmail_username: ENV['FOLLOWERS_GMAIL_USERNAME'],
  gmail_password: ENV['FOLLOWERS_GMAIL_PASSWORD'],

  db_name: ENV['FOLLOWERS_DB_NAME'],
  db_hostname: ENV['FOLLOWERS_DB_HOSTNAME'],
  db_username: ENV['FOLLOWERS_DB_USERNAME'],
  db_password: ENV['FOLLOWERS_DB_PASSWORD'],

  log:  STDOUT
).freeze
