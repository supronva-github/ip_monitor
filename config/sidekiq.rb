# frozen_string_literal: true

require 'sidekiq'
require 'sidekiq-cron'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] || 'redis://localhost:6379/0' }

  schedule_file = File.join(Dir.pwd, 'config', 'sidekiq.yml')
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)['schedule'] if File.exist?(schedule_file)
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'] || 'redis://localhost:6379/0' }
end
