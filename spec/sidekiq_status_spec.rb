# frozen_string_literal: true

RSpec.describe SidekiqStatus do
  it 'has a version number' do
    expect(SidekiqStatus::VERSION).not_to be nil
  end

  describe '.print_usage' do
    let(:expected_output) do
      <<~USAGE
        sidekiq_status - Sidekiq process reporting.

        Usage: sidekiq_status

               -a, --alive
                 check if at least 1 Sidekiq process is running
                 sets the exit code to 1 if no process if found

               -r, --report [SECTION_NAME]
                 view the status report
                 SECTION_NAME is optional and filters the report to a specific section
                 Valid sections are: all, version, overview, processes, queues
                 Default is 'all'

      USAGE
    end

    it 'prints the help message' do
      stub_const("#{described_class}::CMD", 'sidekiq_status')
      expect do
        described_class.print_usage
      end.to output(expected_output).to_stdout
    end
  end

  describe '.status' do
    let(:view_double) { instance_double('SidekiqStatus::View') }

    before do
      allow(view_double).to receive(:display)
      allow(SidekiqStatus::View).to receive(:new).and_return(view_double)
    end

    it 'calls the view object with the default' do
      described_class.status
      expect(view_double).to have_received(:display).with('all')
    end

    it 'calls the view object with the section param' do
      described_class.status('test')
      expect(view_double).to have_received(:display).with('test')
    end
  end
end
