# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  add_filter 'spec/'
end

if ENV['CI'] == 'true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require 'rspec'
require 'cross_service_messenger'
