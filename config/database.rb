# frozen_string_literal: true

DB_CONFIG = {
  adapter: :postgres,
  user: ENV['DB_USER'],
  password: ENV['DB_PASSWORD'],
  database: ENV['DB_NAME'],
  port: ENV['DB_PORT']
}.freeze

DB = Sequel.connect(DB_CONFIG)
