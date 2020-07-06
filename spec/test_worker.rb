# frozen_string_literal: true

class TestWorker
  # include Sidekiq::Worker

  def perform
    sleep 1
  end
end
