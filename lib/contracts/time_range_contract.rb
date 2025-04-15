# frozen_string_literal: true

class TimeRangeContract < Dry::Validation::Contract
  params do
    optional(:time_from).maybe(:string)
    optional(:time_to).maybe(:string)
  end

  rule(:time_from) do
    DateTime.iso8601(value) if value
  rescue Date::Error
    key.failure('must be in ISO8601 format, e.g. 2025-04-15T10:00:00')
  end

  rule(:time_to) do
    DateTime.iso8601(value) if value
  rescue Date::Error
    key.failure('must be in ISO8601 format, e.g. 2025-04-15T10:00:00')
  end

  rule(:time_from, :time_to) do
    if values[:time_from] && values[:time_to]
      begin
        from = DateTime.iso8601(values[:time_from].strip)
        to   = DateTime.iso8601(values[:time_to].strip)
        key(:time_from).failure('must be earlier than time_to') if from > to
      rescue Date::Error # rubocop:disable Lint/SuppressedException
      end
    end
  end
end
