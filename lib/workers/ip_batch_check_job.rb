# frozen_string_literal: true

class IpBatchCheckJob
  include Sidekiq::Worker

  def perform(batch)
    batch.each do |ip_id, ip_address|
      result = PingCheckerService.new(ip_address).call
      IpCheck.create(ip_id: ip_id, rtt: result[:rtt])
    end
  end
end
