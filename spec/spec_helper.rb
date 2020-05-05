# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_filter 'spec/'
end

require 'rspec'
# require 'rack/test'
require 'cross_service_messenger'

# RSpec.configure do |conf|
#   conf.include Rack::Test::Methods
# end
