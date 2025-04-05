# frozen_string_literal: true

namespace :db do
  desc 'Checking status migrations'
  task :status do
    Sequel.extension :migration

    begin
      result = Sequel::Migrator.check_current(DB, 'db/migrations')
      puts '✅ All migrations are up to date' if result.nil?
    rescue Sequel::Migrator::NotCurrentError => e
      puts "❌ Migration version conflict: #{e.message}"
      puts "👉 Run 'rake db:migrate' to apply migrations"
    end

    migration_files = Dir['db/migrations/*.rb'].map { |file| File.basename(file) }

    migrations_in_schema = DB[:schema_migrations].select_map(:filename)

    migration_files.each do |migration|
      if migrations_in_schema.include?(migration)
        puts "#{migration} ➡️  up"
      else
        puts "#{migration} ➡️  down"
      end
    end
  end
end
