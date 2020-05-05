# frozen_string_literal: true

require 'cross_service_messenger/version'
require 'cross_service_messenger/client'

# Service for send/pull messages.
module CrossServiceMessenger
  class << self
    # AWS access key
    attr_accessor :aws_access_key_id

    # AWS secret access key
    attr_accessor :aws_secret_access_key

    # AWS region
    attr_accessor :aws_region

    # AWS SQS queue names
    attr_writer :queue_names

    # Public: Default way to set up CrossServiceMessenger.
    def setup
      yield self
    end

    # Public: Get queue names.
    #
    # @return [Hash<Symbol, String>] the queue names.
    def queue_names
      @queue_names ||= {}
    end

    # Public: Send message to app.
    #
    # @param app [String, Symbol] the app name.
    # @param message_body [String] the message.
    def send_to(app, message_body)
      CrossServiceMessenger::Client.new(:"to_#{app.to_s.downcase}").send_message(message_body)
    end

    # Public: Pull messages from app.
    #
    # @param app [String, Symbol] the app name.
    def pull_from(app, &block)
      CrossServiceMessenger::Client.new(:"from_#{app.to_s.downcase}").pull(&block)
    end
  end
end
