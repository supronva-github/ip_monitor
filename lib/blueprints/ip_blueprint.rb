# frozen_string_literal: true

class IpBlueprint < Blueprinter::Base
  identifier :id

  fields :ip_address, :enabled
end
