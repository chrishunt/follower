require 'rspec/core/rake_task'
require './lib/followers'

task :default => :spec

desc 'Run all specs'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w(--color --order random)
end

# Heroku runs this cron task hourly
desc 'Update followers and send email'
task :cron do
  `ruby bin/update`
end

namespace :db do
  desc "Create #{CONFIG.db_name} database"
  task :migrate do
    require 'pg'

    PG.connect(
      CONFIG.db_hostname, 5432, '', '',
      CONFIG.db_name,
      CONFIG.db_username,
      CONFIG.db_password
    ).exec <<-SQL
      CREATE TABLE IF NOT EXISTS #{CONFIG.db_name} (
        id SERIAL PRIMARY KEY,
        poll_time TIMESTAMP,
        user_ids TEXT
      )
    SQL
  end
end
