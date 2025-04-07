# frozen_string_literal: true

class ErrorResponseBlueprint < Blueprinter::Base
  field :errors do |error|
    {
      code: error[:code],
      message: error[:message]
    }
  end
end
