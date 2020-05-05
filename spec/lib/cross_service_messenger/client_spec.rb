# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CrossServiceMessenger::Client do
  it { expect(described_class.queue_urls).to eq({}) }

  before do
    allow(CrossServiceMessenger).to receive(:aws_access_key_id) { 'foo' }
    allow(CrossServiceMessenger).to receive(:aws_secret_access_key) { 'bar' }
    allow(CrossServiceMessenger).to receive(:aws_region) { 'qux' }
  end

  describe '#send_message' do
    subject { described_class.new(:to_app) }

    it 'sends a message to app' do
      allow(subject).to receive(:queue_url) { 'http://example.com' }
      expect(described_class.client).to receive(:send_message)
      subject.send_message('foo')
    end
  end

  describe '#pull' do
    subject { described_class.new(:from_app) }

    it 'pulls a messages from app' do
      allow(subject).to receive(:queue_url) { 'http://example.com' }
      expect_any_instance_of(Aws::SQS::QueuePoller).to receive(:poll)
      subject.pull
    end
  end

  describe '#queue_url' do
    let(:url) { 'http://example.com' }
    subject   { described_class.new(:from_app).send(:queue_url) }

    it { expect { subject }.to raise_error(KeyError) }

    it 'returns a URL if queue name is exists' do
      allow(CrossServiceMessenger).to receive(:queue_names) { { from_app: 'other_app_test_to_my_app_test' } }
      allow(described_class.client).to receive(:get_queue_url) { double(queue_url: url) }
      expect do
        expect(subject).to eq url
      end.to change { described_class.queue_urls }.from({}).to(from_app: url)
    end
  end
end
