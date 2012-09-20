# Followers

Keep track of who starts and stops following you on
[Twitter](https://twitter.com).

## Getting Started

```
$ git clone https://github.com/chrishunt/follower.git
$ cd follower
$ bundle exec db:migrate
$ vi config/followers.rb
```

Edit the config file in `config/followers.rb` and update with your Twitter
username, api token, api secret, oauth token, and oauth secret.

```ruby
username:     'chrishunt',
api_token:    'API_TOKEN',
api_secret:   'API_SECRET',
oauth_token:  'OAUTH_TOKEN',
oauth_secret: 'OAUTH_SECRET'
```

## Usage

Each time you run the update script, your followers will be downloaded in the
download directory and compared against the last time you ran the script.
You'll be notified if a user has started or stopped following you.

```
$ ./bin/update

chrishunt has 201 followers today

2 users have started following you :)
bobmarley, rubyguy

1 users have stopped following you :(
javadude

Open followers in browser? (y)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
