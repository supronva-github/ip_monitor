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
    IpBlueprint.render(ips)
  end

  post '/ips' do
    body = JSON.parse(request.body.read)

    contract = IpContract.new.call(body)

    if contract.success?
      ip = Ip.create(contract.to_h)
      IpBlueprint.render(ip)
    else
      status 422
      ErrorResponseBlueprint.render({ code: 'unprocessable_entity', message: contract.errors.to_h })
    end
  end

  post '/ips/:id/enable' do
    ip = Ip.first!(id: params[:id].to_i)
    ip.update(enabled: true)
    status 204
  end

  post '/ips/:id/disable' do
    ip = Ip.first!(id: params[:id].to_i)
    ip.update(enabled: false)
    status 204
  end

  delete '/ips/:id' do
    ip = Ip.first!(id: params[:id].to_i)
    ip.destroy
    status 204
  end
end
