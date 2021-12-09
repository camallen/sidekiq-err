# frozen_string_literal: true

module SidekiqR
  class Error < StandardError; end
  class NoProcessFound < Error; end
end