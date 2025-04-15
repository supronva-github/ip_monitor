# frozen_string_literal: true

class IpStatsService
  def initialize(ip_id, time_from = nil, time_to = nil)
    @ip_id = ip_id
    @time_to = time_to ? DateTime.iso8601(time_to) : Time.now
    @time_from = time_from ? DateTime.iso8601(time_from) : @time_to - 3600
  end

  def call
    stats = DB.fetch(stats_query, ip_id: @ip_id, time_from: @time_from, time_to: @time_to).first
    return { error: 'No data available for the specified period' } if stats.nil?

    stats.transform_values { |v| v&.round(2) }
  end

  private

  def stats_query
    <<-SQL
      SELECT
        AVG(rtt) AS avg_rtt,
        MIN(rtt) AS min_rtt,
        MAX(rtt) AS max_rtt,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY rtt) AS median_rtt,
        STDDEV(rtt) AS std_dev_rtt,
        (COUNT(CASE WHEN rtt IS NULL THEN 1 END)::float / NULLIF(COUNT(*), 0) * 100) AS packet_loss
      FROM ip_checks ic
      WHERE ic.ip_id = :ip_id
        AND ic.created_at >= :time_from
        AND ic.created_at <= :time_to
        AND EXISTS (
          SELECT 1
          FROM ip_status_changes isc
          WHERE isc.ip_id = ic.ip_id
            AND isc.created_at <= ic.created_at
            AND isc.status = TRUE
            AND NOT EXISTS (
              SELECT 1
              FROM ip_status_changes isc2
              WHERE isc2.ip_id = isc.ip_id
                AND isc2.created_at > isc.created_at
                AND isc2.created_at <= ic.created_at
                AND isc2.status = FALSE
            )
        )
      HAVING COUNT(*) > 0;
    SQL
  end
end
