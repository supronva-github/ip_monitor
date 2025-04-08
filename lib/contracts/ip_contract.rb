# frozen_string_literal: true

class IpContract < Dry::Validation::Contract
  FORBIDDEN_RANGES = [
    IPAddress('0.0.0.0/8'),
    IPAddress('127.0.0.0/8'),
    IPAddress('169.254.0.0/16'),
    IPAddress('224.0.0.0/4'),
    IPAddress('255.255.255.255')
  ].freeze

  params do
    required(:ip_address).filled(:string)
    optional(:enabled).filled(:bool)
  end

  rule(:ip_address) do
    ip = IPAddress(value)

    if FORBIDDEN_RANGES.any? { |range| range.include?(ip) }
      key.failure('IP is forbidden')
    elsif Ip.where(ip_address: value).any?
      key.failure('IP address must be unique')
    end
  rescue ArgumentError
    key.failure('IP address is not valid')
  end
end
