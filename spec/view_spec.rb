# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SidekiqStatus::View do
  let(:process_set) do
    instance_double(
      'Sidekiq::ProcessSet',
      size: 1,
      each_with_index: [
        Sidekiq::Process.new(
          hostname: "a03dc1421fe6",
          started_at: 1594054991.2349708,
          pid: 55,
          tag: '',
          concurrency: 10,
          queues: ['default'],
          labels: [],
          identity: 'a03dc1421fe6:55:b94b1ede3adf',
          busy: 0,
          beat: 1594055026.3869414,
          quiet: 'false'
        )
      ]
    )
  end
  let(:stats) do
    instance_double(
      'Sidekiq::Stats',
      processed: 0,
      failed: 0,
      scheduled_size: 0,
      retry_size: 0,
      dead_size: 0,
      processes_size: 0,
      default_queue_latency: 0,
      workers_size: 0,
      enqueued: 0
    )
  end
  let(:queue_data) do
    instance_double(
      'Sidekiq::Queue',
      name: 'default',
      size: 0,
      latency: 0
    )
  end
  let(:view_instance) { described_class.new }

  before do
    allow(Sidekiq::ProcessSet).to receive(:new).and_return(process_set)
    allow(Sidekiq::Stats).to receive(:new).and_return(stats)
    allow(Sidekiq::Queue).to receive(:all).and_return([queue_data])
  end

  describe '.display' do
    it 'raises an error if invalid section' do
      expect do
        view_instance.display('invalid')
      end.to raise_error(SidekiqStatus::View::InvalidSection)
    end

    it 'calls the revelant section method' do
      allow(view_instance).to receive(:all)
      view_instance.display('all')
      expect(view_instance).to have_received(:all).once
    end
  end

  describe '.all' do
    # take care when testing exit codes...
    # ensure we don't SystemExit: exit here
    it 'calls all the sections' do
      allow(view_instance).to receive(:version)
      allow(view_instance).to receive(:overview)
      allow(view_instance).to receive(:processes)
      allow(view_instance).to receive(:queues)
      allow(view_instance).to receive(:puts)
      view_instance.all
      expect(view_instance).to have_received(:puts).exactly(3).times
      expect(view_instance).to have_received(:version).once
      expect(view_instance).to have_received(:overview).once
      expect(view_instance).to have_received(:processes).once
      expect(view_instance).to have_received(:queues).once
    end
  end

  describe '.version' do
    it 'reports with Version text' do
      expect do
        view_instance.version
      end.to output(a_string_including("Sidekiq #{Sidekiq::VERSION}")).to_stdout
    end
  end

  describe '.overview' do
    it 'reports with Overview text' do
      expect do
        view_instance.overview
      end.to output(a_string_including('---- Overview ----')).to_stdout
    end
  end

  describe '.processes' do
    it 'reports the Processes text' do
      expect do
        view_instance.processes
      end.to output(a_string_including('---- Processes (1) ----')).to_stdout
    end
  end

  describe '.queues' do
    it 'reports the Queues text' do
      expect do
        view_instance.queues
      end.to output(a_string_including('---- Queues (1) ----')).to_stdout
    end
  end
end
