# frozen_string_literal: true

RSpec.describe SidekiqStatus::View do
  describe '.print_usage' do
    let(:expected_output) do
      <<~USAGE
        sidekiq_status - Sidekiq process stats from the command line.

        Usage: sidekiq_status <section>

               <section> (optional) view a specific section of the status output
               Valid sections are: all, version, overview, processes, queues
               Default is 'processes'

      USAGE
    end
    it 'prints the help message' do
      stub_const("#{described_class}::CMD", 'sidekiq_status')
      expect do
        described_class.print_usage
      end.to output(expected_output).to_stdout
    end
  end

  describe '#display' do
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
    before do
      allow(Sidekiq::ProcessSet).to receive(:new).and_return(process_set)
      allow(Sidekiq::Stats).to receive(:new).and_return(stats)
      allow(Sidekiq::Queue).to receive(:all).and_return([queue_data])
    end

    context "'all' section" do
      it 'reports the Overview section' do
        expect do
          described_class.new.display('all')
        end.to output(a_string_including('---- Overview ----')).to_stdout
      end

      it 'reports the Process section' do
        expect do
          described_class.new.display('all')
        end.to output(a_string_including('---- Processes (1) ----')).to_stdout
      end

      it 'reports the Queues section' do
        expect do
          described_class.new.display('all')
        end.to output(a_string_including('---- Queues (1) ----')).to_stdout
      end
    end
  end
end
