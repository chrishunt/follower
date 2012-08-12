#!/usr/bin/env ruby
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

current_followers = Followers::TwitterClient.followers(TWITTER_USERNAME)
puts "#{TWITTER_USERNAME} has #{current_followers.count} followers today"

previous_followers = Dir["#{DOWNLOAD_DIR}/*"].last

if previous_followers
  previous_followers = JSON.parse(File.read(previous_followers))

  lost   = compare(:lost, previous_followers, current_followers)
  gained = compare(:gained, previous_followers, current_followers)

  print_comparison(:lost, lost) unless lost.empty?
  print_comparison(:gained, gained) unless gained.empty?
end

unless lost.empty? && gained.empty?
  print "\nOpen followers in browser? (y) "
  answer = gets.chomp.downcase

  if ['', 'y'].include?(answer)
    urls = lost.push(gained).flatten.map { |user| "#{TWITTER_URL}/#{user}" }
    system "open #{urls.join(' ')}"
  end
end

filename  = "downloads/#{Time.now.strftime('%Y%m%d_%H%M%S')}.json"
File.open(filename, 'w') { |f| f.write current_followers.to_json }
