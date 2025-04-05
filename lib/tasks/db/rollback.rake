# frozen_string_literal: true

namespace :db do
  desc 'Rollback the last migration'
  task :rollback do
    Sequel.extension :migration
    Sequel::Migrator.run(DB, 'db/migrations', target: -1)
    puts '✅ Rollback of the last migration was successful'
  rescue Sequel::Error => e
    puts "❌ Error: #{e.message}"
  end
end
