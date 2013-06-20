# Followers

Keep track of who starts and stops following you on
[Twitter](https://twitter.com).

## Throw It On Heroku

Checkout the project:

```bash
$ git clone https://github.com/chrishunt/follower.git
$ cd follower
```

Push to Heroku:

```bash
$ heroku init
$ git push heroku master
```

Add PostgreSQL and Scheduler addons:

```bash
$ heroku addons:add heroku-postgresql:dev scheduler:standard
```

Set your Twitter handle and consumer keys:

```bash
$ heroku config:set TWITTER_USERNAME=...
$ heroku config:set TWITTER_CONSUMER_KEY=...
$ heroku config:set TWITTER_CONSUMER_SECRET=...
```

Set email credentials for notifications:

```bash
$ heroku config:set FOLLOWERS_DELIVERY_EMAIL=...
$ heroku config:set FOLLOWERS_GMAIL_USERNAME=...
$ heroku config:set FOLLOWERS_GMAIL_PASSWORD=...
```

Migrate Heroku database:

```
$ heroku run rake db:migrate
```

Add an hourly update task on Heroku for `rake cron`:

```
$ heroku addons:open scheduler:standard
```

Done.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
