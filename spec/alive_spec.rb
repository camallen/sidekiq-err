# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SidekiqErr::Alive do
  let(:hostname) { 'a03dc1421fe6' }
  let(:process_set) { instance_double('Sidekiq::ProcessSet', size: 1) }
  let(:process) do
    Sidekiq::Process.new(
      'hostname' => hostname,
      'started_at' => 1594054991.2349708,
      'pid' => 55,
      'tag' => '',
      'concurrency' => 10,
      'queues' => ['default'],
      'labels' => [],
      'identity' => 'a03dc1421fe6:55:b94b1ede3adf',
      'busy' => 0,
      'beat' => 1594055026.3869414,
      'quiet' => 'false'
    )
  end

  before do
    allow(process_set).to receive(:find).and_yield(process)
  end

  describe '.is_running?' do
    it 'raises an error if no sidekiq processes is present' do
      expect do
        described_class.check?(hostname)
      end.to raise_error(SidekiqErr::NoProcessFound, "No sidekiq process found for hostname: #{hostname}")
    end

    it 'does not raise if sidekiq processes name can be found' do
      allow(Sidekiq::ProcessSet).to receive(:new).and_return(process_set)
      expect { described_class.check?(hostname) }.not_to raise_error
    end

    it 'raises if the process name can not be found' do
      allow(Sidekiq::ProcessSet).to receive(:new).and_return(process_set)

      expect do
        described_class.check?('wat-host')
      end.to raise_error(SidekiqErr::NoProcessFound, "No sidekiq process found for hostname: wat-host")
    end
  end
end
