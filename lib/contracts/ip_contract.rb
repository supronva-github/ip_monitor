# frozen_string_literal: true

class IpContract < Dry::Validation::Contract
  params do
    required(:ip_address).filled(:string)
    optional(:enabled).filled(:bool)
  end

  rule(:ip_address) do
    IPAddress(value)
  rescue ArgumentError
    key.failure('IP address is not valid')
  end

  rule(:ip_address) do
    key.failure('IP address must be unique') if Ip.where(ip_address: value).any?
  end
end
