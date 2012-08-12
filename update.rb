#!/usr/bin/env ruby
require './lib/followers'

def colorize(text, code)
  "\e[#{code}m#{text}\e[0m"
end

current_followers = Followers::TwitterClient.followers(TWITTER_USERNAME)
puts "#{TWITTER_USERNAME} has #{current_followers.count} followers today"

previous_followers = Dir["#{DOWNLOAD_DIR}/*"].last

if previous_followers
  previous_followers = JSON.parse(File.read(previous_followers))

  lost = Followers::TwitterClient.users_lookup(
    Followers::Comparison.lost(previous_followers, current_followers)
  ).map { |f| f['screen_name'] }

  gained = Followers::TwitterClient.users_lookup(
    Followers::Comparison.gained(previous_followers, current_followers)
  ).map { |f| f['screen_name'] }

  unless lost.empty?
    puts colorize("\n#{lost.count} users have stopped following you :(", 31)
    puts lost.join(', ')
  end

  unless gained.empty?
    puts colorize("\n#{gained.count} users have started following you :)", 32)
    puts gained.join(', ')
  end
end

filename  = "downloads/#{Time.now.strftime('%Y%m%d_%H%M%S')}.json"
File.open(filename, 'w') { |f| f.write current_followers.to_json }
