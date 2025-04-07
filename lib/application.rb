# frozen_string_literal: true

require 'sinatra/strong-params'

class Application < Sinatra::Base
  configure do
    register Sinatra::StrongParams
  end
end
