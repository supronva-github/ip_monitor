# frozen_string_literal: true

require_relative 'config/initializers'
require_relative 'config/database'

Dir[File.join(File.dirname(__FILE__), 'lib', 'tasks', '**', '*.rake')].each do |file|
  load file
end
