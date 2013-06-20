module Followers
  class Updater
    def run
      log [
        '', Time.now,
        'Starting update...',
        "Current followers: #{current_followers.count}"
      ]

      unless previous_followers.empty?
        log [
          "Previous followers: #{previous_followers.count}",
          "Lost (#{lost_followers.count}): #{lost_followers_screen_names}",
          "Gained (#{gained_followers.count}): #{gained_followers_screen_names}"
        ]
      else
        log 'No previous followers'
      end

      save_follower_count(current_followers)

      if followers_changed?
        log 'Sending email...'
        deliver_email
      else
        log 'Not sending email'
      end

      db.close
    end

    private

    def deliver_email
      Mailer.followers(
        CONFIG.username,
        current_followers.count,
        lost_followers,
        gained_followers
      ).deliver
    end

    def gained_followers?
      gained_followers.count > 0
    end

    def lost_followers?
      lost_followers.count > 0
    end

    def followers_changed?
      gained_followers? || lost_followers?
    end

    def lost_followers_screen_names
      lost_followers.map { |f| f['screen_name'] }
    end

    def gained_followers_screen_names
      gained_followers.map { |f| f['screen_name'] }
    end

    def current_followers
      @current_followers ||= twitter_client.follower_ids_for(CONFIG.username)
    end

    def previous_followers
      unless @previous_followers
        db.exec(
          "SELECT user_ids FROM followers ORDER BY poll_time DESC LIMIT 1"
        ).each do |result|
          @previous_followers = JSON.parse(result['user_ids'])
        end

        @previous_followers ||= []
      end
      @previous_followers
    end

    def log(messages)
      message = if messages.respond_to?(:join)
        messages.join("\n")
      else
        messages
      end

      logger.info message
    end

    def logger
      @logger ||= Logger.new(CONFIG.log)
    end

    def lost_followers
      compare(:lost, previous_followers, current_followers)
    end

    def gained_followers
      compare(:gained, previous_followers, current_followers)
    end

    def compare(comparison, previous, current)
      twitter_client.users_for(
        user_comparison.send(comparison, previous, current)
      )
    end

    def twitter_client
      Followers::TwitterClient
    end

    def user_comparison
      Followers::Comparison
    end

    def db
      @db ||= PG.connect(
        CONFIG.database.host,
        CONFIG.database.port, '', '',
        CONFIG.database.path[1..-1], # database name
        CONFIG.database.user,
        CONFIG.database.password
      )
    end

    def save_follower_count(followers, time = Time.now)
      db.exec <<-SQL
        INSERT INTO followers ( poll_time, user_ids )
        VALUES ( '#{time.to_s}', '#{followers.to_json}' )
      SQL
    end
  end
end
