# frozen_string_literal: true

class Ip < Sequel::Model
  IPV4_REGEX = /^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/x.freeze

  plugin :validation_helpers
  plugin :timestamps, update_on_create: true

  def validate
    super
    validates_presence :ip_address
    validates_format IPV4_REGEX, :ip_address, message: 'is not a valid IPv4 address'
    validate_unique_ip_address
  end

  private

  def validate_unique_ip_address
    return unless self.class.where(ip_address: ip_address).exclude(id: id).any?

    errors.add(:ip_address, 'IP address must be unique')
  end
end
