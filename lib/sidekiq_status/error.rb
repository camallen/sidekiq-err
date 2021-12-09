# frozen_string_literal: true

module SidekiqStatus
  class Error < StandardError; end
  class NoProcessFound < Error; end
end