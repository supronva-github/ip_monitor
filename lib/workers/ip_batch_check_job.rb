# frozen_string_literal: true

class IpBatchCheckJob
  include Sidekiq::Worker

  def perform(batch)
    id_map = build_id_map(batch)
    ip_addresses = extract_ip_addresses(batch)
    results = check_ips(ip_addresses)
    records = prepare_records(results, id_map)
    save_records(records)
  end

  private

  def build_id_map(batch)
    batch.to_h.invert
  end

  def extract_ip_addresses(batch)
    batch.map(&:last)
  end

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
