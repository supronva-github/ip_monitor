# frozen_string_literal: true

namespace :db do
  desc 'Create new migration'
  task :new_migration, [:name] do |_t, args|
    migration_name = args[:name] || 'migration'
    timestamp = Time.now.strftime('%Y%m%d%H%M%S')
    filename = "#{timestamp}_#{migration_name}.rb"
    directory = 'db/migrations'
    migration_path = "#{directory}/#{filename}"

    FileUtils.mkdir_p(directory)

    migration_content = <<~RUBY
      # frozen_string_literal: true

      Sequel.migration do
        change do
        end
      end
    RUBY

    File.write(migration_path, migration_content)
  end
end
