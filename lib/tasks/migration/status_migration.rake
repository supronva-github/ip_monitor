# frozen_string_literal: true

namespace :db do
  desc 'Checking status migrations'
  task :status do
    Sequel.extension :migration
    result = Sequel::Migrator.check_current(DB, 'db/migrations')
    puts 'All migrations are up to date' if result.nil?
  rescue Sequel::Migrator::NotCurrentError => e
    puts "Migration version conflict: #{e.message}"
    puts "Run 'rake db:migrate' to apply migrations"
  end
end
