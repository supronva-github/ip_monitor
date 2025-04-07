# frozen_string_literal: true

require 'sinatra/strong-params'

class Application < Sinatra::Base
  configure do
    register Sinatra::StrongParams

    set :show_exceptions, false
  end

  error JSON::ParserError do
    status 400
    ErrorResponseBlueprint.render({ code: 'bad_request', message: 'Invalid JSON format' })
  end

  error Sequel::NoMatchingRow do
    status 404
    ErrorResponseBlueprint.render({ code: 'not_found', message: 'Resource not found' })
  end
end
