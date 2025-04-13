# frozen_string_literal: true

class IpCheckWorker
  BATCH_SIZE = 50

  include Sidekiq::Worker

  def perform
    Ip.where(enabled: true).select_map(%i[id ip_address]).each_slice(BATCH_SIZE) do |batch|
      IpBatchCheckJob.perform_async(batch)
    end
  end
end
