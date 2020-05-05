# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cross_service_messenger/version'

Gem::Specification.new do |spec|
  spec.name          = 'cross-service-messenger'
  spec.version       = CrossServiceMessenger::VERSION
  spec.authors       = ['Aleksei Vokhmin']
  spec.email         = ['avokhmin@gmail.com']
  spec.summary       = 'Service for communicate apps via AWS SQS.'
  spec.description   = 'Service for communicate apps via AWS SQS.'
  spec.homepage      = 'https://github.com/Shuttlerock/cross-service-messenger'
  spec.license       = 'MIT'

  spec.files         = Dir.glob('lib/**/*') + %w(LICENSE README.md)
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ['lib']
  spec.platform      = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.6.0'

  spec.add_development_dependency 'rspec',                     '>= 3.9.0'
  spec.add_development_dependency 'rubocop-performance',       '>= 1.5.2'
  spec.add_development_dependency 'shuttlerock_shared_config', '>= 0.2.29'
  spec.add_development_dependency 'simplecov',                 '>= 0.16.0'

  spec.add_runtime_dependency 'aws-sdk-sqs', '>= 1.24.0'
end
