# frozen_string_literal: true

require 'bundler/setup'

ENV['RACK_ENV'] ||= 'development'

Bundler.require(:default, ENV['RACK_ENV'])

Dotenv.load

require_relative 'zeitwerk'
