# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CrossServiceMessenger do

  it { expect(described_class.aws_access_key_id).to be_nil }
  it { expect(described_class.aws_secret_access_key).to be_nil }
  it { expect(described_class.aws_region).to be_nil }
  it { expect(described_class.queue_names).to eq({}) }

  describe '::setup' do
    it { expect { described_class.setup { |csm| csm.aws_access_key_id = 'foo' } }.to change(described_class, :aws_access_key_id).to('foo') }
  end

  describe '::send_to' do
    it 'sends message to app' do
      expect_any_instance_of(described_class::Client).to receive(:send_message)
      CrossServiceMessenger.send_to(:foo, 'bar')
    end
  end

  describe '::pull_from' do
    it 'pulls messages from app' do
      expect_any_instance_of(described_class::Client).to receive(:pull)
      CrossServiceMessenger.pull_from(:foo)
    end
  end
end
