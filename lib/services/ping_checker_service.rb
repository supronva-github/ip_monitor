# frozen_string_literal: true

class PingCheckerService
  TIMEOUT = 1

  def initialize(ip_address)
    @ip_address = ip_address
  end

  def call
    ping = Net::Ping::External.new(@ip_address, timeout: TIMEOUT)
    start_time = Time.now
    success = ping.ping?

    { rtt: success ? (Time.now - start_time) * 1000 : nil }
  rescue StandardError
    { rtt: nil }
  end
end
