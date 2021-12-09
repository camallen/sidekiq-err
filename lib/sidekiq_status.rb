# frozen_string_literal: true

require 'sidekiq_status/version'
require 'sidekiq_status/error'
require 'sidekiq_status/alive'
require 'sidekiq_status/view'
require 'fileutils'
require 'sidekiq/api'

module SidekiqStatus
  CMD = File.basename($PROGRAM_NAME)

  def self.print_usage
    puts "#{CMD} - Sidekiq process reporting."
    puts
    puts "Usage: #{CMD}"
    puts
    puts '       -a, --alive'
    puts '         check if at least 1 Sidekiq process is running'
    puts '         sets the exit code to 1 if no process if found'
    puts
    puts '       -r, --report [SECTION_NAME]'
    puts '         view the status report'
    puts '         SECTION_NAME is optional and filters the report to a specific section'
    puts "         Valid sections are: #{View.valid_sections.join(', ')}"
    puts "         Default is 'all'"
    puts
  end

  def self.status(section = nil)
    section ||= 'all'
    SidekiqStatus::View.new(section).display
  end

  def self.alive?
    SidekiqStatus::Alive.check?
  end
end
