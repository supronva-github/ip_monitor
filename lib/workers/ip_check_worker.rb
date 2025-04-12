# frozen_string_literal: true

class IpCheckWorker
  include Sidekiq::Worker
  sidekiq_options retry: 3

  def perform
    Ip.where(enabled: true).each do |ip|
      result = PingCheckerService.new(ip.ip_address).call
      IpCheck.create(ip_id: ip.id, rtt: result[:rtt])
    end
  end
end
