# Followers

Keep track of who starts and stops following you on
[Twitter](https://twitter.com).

## Getting Started

```
$ git clone https://github.com/chrishunt/follower.git
$ cd follower
$ vi config/followers_config.rb
```

To get started, edit the config file in `config/followers_config.rb` and update
with your twitter username. By default, your twitter follower history will be
saved in `./downloads`

```ruby
TWITTER_URL      = 'https://twitter.com'
TWITTER_API      = 'https://api.twitter.com/1'
TWITTER_USERNAME = 'chrishunt'
DOWNLOAD_DIR     = 'downloads'
```

## Running The Script

```
$ ./update.rb

chrishunt has 201 followers today

2 users have started following you :)
bobmarley, rubyguy

1 users have stopped following you :(
javadude

Open followers in browser? (y)
```
