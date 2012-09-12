#!/usr/bin/env ruby

require './lib/followers'

def compare(comparison, previous, current)
  Followers::TwitterClient.users_lookup(
    Followers::Comparison.send(comparison, previous, current)
  ).map { |f| f['screen_name'] }
end

log = Logger.new(CONFIG.log)
log.info '' # blank line
log.info Time.now
log.info "Starting update..."

current_followers = Followers::TwitterClient.followers(CONFIG.username)
log.info "Current followers: #{current_followers.count}"

previous_followers = nil
lost = nil
gained = nil

db = PG.connect(dbname: CONFIG.database)

db.exec(
  "SELECT user_ids FROM followers ORDER BY poll_time DESC LIMIT 1"
).each do |result|
  previous_followers = JSON.parse(result['user_ids'])
end

if previous_followers
  lost   = compare(:lost, previous_followers, current_followers)
  gained = compare(:gained, previous_followers, current_followers)

  log.info "Previous followers: #{previous_followers.count}"
  log.info "Lost: #{lost.count}"
  log.info "Gained: #{gained.count}"
else
  log.info "No previous followers"
end

db.exec <<-SQL
  INSERT INTO #{CONFIG.database} ( poll_time, user_ids )
  VALUES ( '#{Time.now.to_s}', '#{current_followers.to_json}' )
SQL

db.close

if gained.count > 0 || lost.count > 0
  log.info "Sending email..."

  Mailer.followers(
    CONFIG.username,
    current_followers.count,
    lost,
    gained
  ).deliver
else
  log.info "Not sending email"
end
