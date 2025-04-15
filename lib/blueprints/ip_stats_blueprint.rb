# frozen_string_literal: true

class IpStatsBlueprint < Blueprinter::Base
  fields :avg_rtt, :min_rtt, :max_rtt, :median_rtt, :std_dev_rtt, :packet_loss
end
