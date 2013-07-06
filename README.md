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

Setup to/from email address:

```bash
$ heroku config:set FOLLOWERS_TO_EMAIL_ADDRESS=...
$ heroku config:set FOLLOWERS_FROM_EMAIL_ADDRESS=...
```

Setup SMTP credentials:

```bash
$ heroku config:set FOLLOWERS_SMTP_ADDRESS=..
$ heroku config:set FOLLOWERS_SMTP_PORT=..
$ heroku config:set FOLLOWERS_SMTP_USERNAME=..
$ heroku config:set FOLLOWERS_SMTP_PASSWORD=..
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
