CONFIG = OpenStruct.new(
  username:   'chrishunt',

  url:        'https://twitter.com',
  api:        'https://api.twitter.com/1',
  api_token:  '',
  api_secret: '',

  oauth_token:  '',
  oauth_secret: '',

  deliver_email:  '',
  gmail_username: '',
  gmail_password: '',

  database: 'followers',
  log:  STDOUT
).freeze
