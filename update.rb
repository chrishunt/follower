#!/usr/bin/env ruby

require 'pg'
require './lib/followers'

def colorize(text, code)
  "\e[#{code}m#{text}\e[0m"
end

def compare(comparison, previous, current)
  Followers::TwitterClient.users_lookup(
    Followers::Comparison.send(comparison, previous, current)
  ).map { |f| f['screen_name'] }
end

def print_comparison(comparison, followers)
  lost = comparison == :lost

  message  = "\n#{followers.count} users have "
  message += lost ? 'stopped' : 'started'
  message += ' following you '
  message += lost ? ':(' : ':)'
  color    = lost ? 31 : 32

  puts colorize(message, color)
  puts followers.join(', ')
end

db = PG.connect(dbname: CONFIG.database)

current_followers = Followers::TwitterClient.followers(CONFIG.username)
puts "#{CONFIG.username} has #{current_followers.count} followers today"

previous_followers = nil
db.exec(
  "SELECT user_ids FROM followers ORDER BY poll_time DESC LIMIT 1"
).each do |result|
  previous_followers = JSON.parse(result['user_ids'])
end

if previous_followers
  lost   = compare(:lost, previous_followers, current_followers)
  gained = compare(:gained, previous_followers, current_followers)

  print_comparison(:lost, lost) unless lost.empty?
  print_comparison(:gained, gained) unless gained.empty?

  unless lost.empty? && gained.empty?
    print "\nOpen followers in browser? (y) "
    answer = gets.chomp.downcase

    if ['', 'y'].include?(answer)
      urls = lost.push(gained).flatten.map { |user| "#{CONFIG.url}/#{user}" }
      system "open #{urls.join(' ')}"
    end
  end
end

db.exec <<-SQL
  INSERT INTO #{CONFIG.database} ( poll_time, user_ids )
  VALUES ( '#{Time.now.to_s}', '#{current_followers.to_json}' )
SQL

db.close
