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
  desc "Create followers table in the database"
  task :migrate do
    require 'pg'

    PG.connect(
      CONFIG.database.host,
      CONFIG.database.port, '', '',
      CONFIG.database.path[1..-1], # database name
      CONFIG.database.user,
      CONFIG.database.password
    ).exec <<-SQL
      CREATE TABLE IF NOT EXISTS followers (
        id SERIAL PRIMARY KEY,
        poll_time TIMESTAMP,
        user_ids TEXT
      )
    SQL
  end
end
