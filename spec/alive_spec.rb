# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SidekiqR::Alive do
  let(:process_set) do
    instance_double('Sidekiq::ProcessSet', size: 1)
  end

  describe '.is_running?' do
    it 'raises an error if no sidekiq processes is present' do
      expect do
        described_class.check?
      end.to raise_error(SidekiqR::NoProcessFound, 'No sidekiq process running!')
    end

    it 'does not raise if sidekiq processes is present' do
      allow(Sidekiq::ProcessSet).to receive(:new).and_return(process_set)
      expect { described_class.check? }.not_to raise_error
    end
  end
end
