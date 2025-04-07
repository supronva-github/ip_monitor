# frozen_string_literal: true

class IpSerializer < Blueprinter::Base
  identifier :id

  fields :ip_address, :enabled
end
