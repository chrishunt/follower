# Followers

Keep track of who starts and stops following you on
[Twitter](https://twitter.com).

## Getting Started

```
$ git clone https://github.com/chrishunt/follower.git
$ cd follower
$ vi config/followers_config.rb
```

Edit the config file in `config/followers_config.rb` and update with your
Twitter username.

```ruby
TWITTER_URL      = 'https://twitter.com'
TWITTER_API      = 'https://api.twitter.com/1'
TWITTER_USERNAME = 'chrishunt'
DOWNLOAD_DIR     = 'downloads'
```

## Running The Script

Each time you run the update script, your followers will be downloaded in the
download directory and compared against the last time you ran the script.
You'll be notified if a user has started or stopped following you.

```
$ ./update.rb

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
