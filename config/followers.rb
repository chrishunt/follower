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

  database: URI.parse(ENV['DATABASE_URL']),

  log: STDOUT
).freeze
