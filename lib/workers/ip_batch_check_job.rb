# frozen_string_literal: true

class IpBatchCheckJob
  include Sidekiq::Worker

  def perform(ip_ids)
    ips = Ip.where(id: ip_ids).select_map(%i[id ip_address])
    id_map = ips.to_h.invert
    results = check_ips(ips.map(&:last))
    records = prepare_records(results, id_map)
    save_records(records)
  end

  private

  def check_ips(ip_addresses)
    PingCheckerService.new(ip_addresses).call
  end

  def prepare_records(results, id_map)
    results.map do |result|
      ip_id = id_map[result[:ip_address]]
      next unless ip_id

      {
        ip_id: ip_id,
        rtt: result[:rtt],
        created_at: Time.now
      }
    end.compact
  end

  def save_records(records)
    IpCheck.multi_insert(records) if records.any?
  end
end
