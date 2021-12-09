# frozen_string_literal: true

RSpec.describe SidekiqErr do
  it 'has a version number' do
    expect(SidekiqErr::VERSION).not_to be nil
  end

  describe '.print_usage' do
    let(:expected_output) do
      <<~USAGE
        sidekiq-err - Sidekiq process reporting.

        Usage: sidekiq-err

               -a, --alive HOSTNAME
                 check if the HOSTNAME is presetn in the Sidekiq process list
                 sets the exit code to 1 if the HOSTNAME process is not found

               -r, --report [SECTION_NAME]
                 view the status report
                 SECTION_NAME is optional and filters the report to a specific section
                 Valid sections are: all, version, overview, processes, queues
                 Default is 'all'

      USAGE
    end

    it 'prints the help message' do
      stub_const("#{described_class}::CMD", 'sidekiq-err')
      expect do
        described_class.print_usage
      end.to output(expected_output).to_stdout
    end
  end

  describe '.status' do
    let(:view_double) { instance_double('SidekiqErr::View') }

    before do
      allow(view_double).to receive(:display)
      allow(SidekiqErr::View).to receive(:new).and_return(view_double)
    end

    it 'correctly instantiates the view instance with the default section' do
      described_class.status
      expect(SidekiqErr::View).to have_received(:new).with('all')
    end

    it 'calls display on the view object' do
      described_class.status
      expect(view_double).to have_received(:display)
    end

    it 'correctly instantiates the view instance with a passed in section param' do
      described_class.status('test')
      expect(SidekiqErr::View).to have_received(:new).with('test')
    end
  end

  describe '.alive?' do
    it 'correctly calls the check? method with hostname param' do
      allow(SidekiqErr::Alive).to receive(:check?)
      described_class.alive?('test')
      expect(SidekiqErr::Alive).to have_received(:check?).with('test')
    end
  end
end
