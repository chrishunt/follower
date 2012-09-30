# Followers

Keep track of who starts and stops following you on
[Twitter](https://twitter.com).

## Throw It On Heroku

Checkout the project.

```
$ git clone https://github.com/chrishunt/follower.git
```

Update configuration `config/followers.rb` with your Twitter handle.

```ruby
username: '...',
```

Push project to Heroku.

```
$ heroku init
$ git push heroku master
```

Add PostgreSQL and Scheduler addons.

```
$ heroku addons:add heroku-postgresql:dev scheduler:standard
```

Add outgoing Gmail credentials to Heroku's for sending email.

```
$ heroku config:add FOLLOWERS_GMAIL_USERNAME= ...
$ heroku config:add FOLLOWERS_GMAIL_PASSWORD= ...
```

Configure email address that will receive follower updates.

```
$ heroku config:add FOLLOWERS_DELIVERY_EMAIL= ...
```

Setup Heroku database.

```
$ heroku run rake db:migrate
```

Add an hourly update task on Heroku for `bin/update`.

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
