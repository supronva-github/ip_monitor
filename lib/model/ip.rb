# frozen_string_literal: true

class Ip < Sequel::Model
  plugin :timestamps, update_on_create: true
end
