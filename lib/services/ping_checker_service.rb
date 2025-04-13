# frozen_string_literal: true

class PingCheckerService
  TIMEOUT = 1
  DEFAULT_THREADS = 25

  def initialize(ip_addresses, thread_count = DEFAULT_THREADS)
    @ip_addresses = Array(ip_addresses)
    @thread_count = thread_count
  end

  def call
    thread_pool = create_thread_pool
    promises = create_promises(thread_pool)
    results = execute_promises(promises)
    shutdown_thread_pool(thread_pool)
    results
  end

  private

  def create_thread_pool
    Concurrent::FixedThreadPool.new(@thread_count)
  end

  def create_promises(thread_pool)
    @ip_addresses.map do |ip_address|
      Concurrent::Promises.future_on(thread_pool) do
        ping_result(ip_address)
      end
    end
  end

  def ping_result(ip_address)
    ping = Net::Ping::External.new(ip_address, timeout: TIMEOUT)
    start_time = Time.now
    success = ping.ping?
    { ip_address: ip_address, rtt: success ? (Time.now - start_time) * 1000 : nil }
  rescue StandardError
    { ip_address: ip_address, rtt: nil }
  end

  def execute_promises(promises)
    Concurrent::Promises.zip(*promises).value!
  end

  def shutdown_thread_pool(thread_pool)
    thread_pool.shutdown
    thread_pool.wait_for_termination
  end
end
