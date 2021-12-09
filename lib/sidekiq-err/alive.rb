# frozen_string_literal: true

module SidekiqErr
  class Alive
    def self.check?
      process_set = Sidekiq::ProcessSet.new
      raise(NoProcessFound, 'No sidekiq process running!') if process_set.size.zero?
    end
  end
end