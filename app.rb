# frozen_string_literal: true

require_relative 'config/initializers'
require_relative 'config/database'

class Application < Sinatra::Base
  get '/' do
    'Hello my IP_MONITOR project'
  end
end
