# frozen_string_literal: true

require_relative 'application'
require_relative 'database'

workers Integer(ENV['WEB_CONCURRENCY'] || 2)

threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

on_worker_boot do
  if defined?(DB)
    DB.disconnect
    DB.connect(DB_CONFIG)
  end
end

rackup DefaultRackup if defined?(DefaultRackup)

bind "tcp://#{ENV['BIND'] || '0.0.0.0'}:#{ENV['PORT'] || 9292}"

environment ENV['RACK_ENV'] || 'development'

worker_timeout 60

pidfile ENV['PIDFILE'] || 'tmp/pids/puma.pid'

stdout_redirect ENV['PUMA_STDOUT'] || 'log/puma.stdout.log',
                ENV['PUMA_STDERR'] || 'log/puma.stderr.log',
                true
