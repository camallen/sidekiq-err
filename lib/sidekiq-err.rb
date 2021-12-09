# frozen_string_literal: true

require 'sidekiq-err/version'
require 'sidekiq-err/error'
require 'sidekiq-err/alive'
require 'sidekiq-err/view'
require 'fileutils'
require 'sidekiq/api'

module SidekiqErr
  CMD = File.basename($PROGRAM_NAME)

  def self.print_usage
    puts "#{CMD} - Sidekiq process reporting."
    puts
    puts "Usage: #{CMD}"
    puts
    puts '       -a, --alive HOSTNAME'
    puts '         check if the HOSTNAME is presetn in the Sidekiq process list'
    puts '         sets the exit code to 1 if the HOSTNAME process is not found'
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
    SidekiqErr::View.new(section).display
  end

  def self.alive?(hostname)
    SidekiqErr::Alive.check?(hostname)
  end
end
