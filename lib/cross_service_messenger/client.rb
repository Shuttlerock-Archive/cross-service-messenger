# frozen_string_literal: true

require 'aws-sdk-sqs'

# Client for send/pull messages from AWS SQS.
class CrossServiceMessenger::Client
  SEMAPHORE = Mutex.new

  # App name
  attr_reader :app

  # Public: Constructor.
  #
  # @param app [Symbol] the app name.
  def initialize(app)
    @app = app
  end

  # Public: Send message.
  #
  # @param message_body [String] the message.
  def send_message(message_body)
    self.class.client.send_message(queue_url: queue_url, message_body: message_body)
  end

  # Public: Pull messages from app.
  def pull
    poller = Aws::SQS::QueuePoller.new(queue_url, client: self.class.client)
    poller.poll(idle_timeout: 5, wait_time_seconds: 5) do |msg|
      yield msg.body
    end
  end

  class << self
    # Public: Get AWS SQS queue urls
    #
    # @return [Hash<Symbol, String>] the queue urls.
    def queue_urls
      @queue_urls ||= {}
    end

    # Public: Get AWS SQS client.
    #
    # @return [Aws::SQS::Client] the client.
    def client
      @client ||= Aws::SQS::Client.new(access_key_id:     CrossServiceMessenger.aws_access_key_id,
                                       secret_access_key: CrossServiceMessenger.aws_secret_access_key,
                                       region:            CrossServiceMessenger.aws_region)
    end
  end

  private

  # Private: Get queue URL.
  #
  # @return [String] the queue URL.
  def queue_url
    @queue_url ||= begin
      SEMAPHORE.synchronize do
        self.class.queue_urls[app] ||= self.class.client.get_queue_url(queue_name: queue_name).queue_url
      end
    end
  end

  # Private: Get queue name.
  #
  # @return [String] the queue name.
  def queue_name
    @queue_name ||= CrossServiceMessenger.queue_names.fetch(app)
  end
end
