# frozen_string_literal: true

module SidekiqErr
  class Error < StandardError; end
  class NoProcessFound < Error; end
end