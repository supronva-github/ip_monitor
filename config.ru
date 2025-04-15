# frozen_string_literal: true

require_relative './config/application'
require './app'
require 'sidekiq/web'

session_opts = {
  secret: SecureRandom.hex(32),
  same_site: true,
  max_age: 86_400
}

use Rack::Session::Cookie, session_opts

use Rack::Auth::Basic, 'Restricted Area' do |username, password|
  username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
end

routes = {
  '/' => App,
  '/sidekiq' => Sidekiq::Web
}

run Rack::URLMap.new(routes)
