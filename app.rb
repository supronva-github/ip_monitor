# frozen_string_literal: true

require_relative 'config/initializers'
require_relative 'config/database'

class App < Application
  before do
    content_type :json
  end

  get '/' do
    'Hello my IP_MONITOR project'
  end

  get '/ips' do
    ips = Ip.all
    IpSerializer.render(ips)
  end
end
