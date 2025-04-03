# frozen_string_literal: true

require_relative 'config/application'

class Application < Sinatra::Base
  get '/' do
    'Hello my IP_MONITOR project'
  end
end
