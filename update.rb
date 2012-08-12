#!/usr/bin/env ruby
require './lib/followers'
require './lib/followers_comparison'

def colorize(text, code)
  "\e[#{code}m#{text}\e[0m"
end

USERNAME  = 'chrishunt'
DIR       = 'downloads'

current_followers = Followers.for(USERNAME)
puts "#{USERNAME} has #{current_followers.count} followers today"

previous_followers = Dir["#{DIR}/*"].last

if previous_followers
  previous_followers = JSON.parse(File.read(previous_followers))

  lost = Followers.identify(
    FollowersComparison.lost(previous_followers, current_followers)
  ).map { |f| f['screen_name'] }

  gained = Followers.identify(
    FollowersComparison.gained(previous_followers, current_followers)
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
