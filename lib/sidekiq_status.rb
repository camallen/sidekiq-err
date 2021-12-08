# frozen_string_literal: true

require 'sidekiq_status/version'
require 'sidekiq_status/view'
require 'fileutils'
require 'sidekiq/api'

module SidekiqStatus
  CMD = File.basename($PROGRAM_NAME)

  def self.print_usage
    puts "#{CMD} - Sidekiq process stats from the command line."
    puts
    puts "Usage: #{CMD} [-q] [section]"
    puts
    puts '       [-q] (optional) do not output text data, rely on exit codes'
    puts
    puts '       [section] (optional) view a specific section of the status output'
    puts "       Valid sections are: #{View.valid_sections.join(', ')}"
    puts "       Default is 'processes'"
    puts
  end

  def self.status(section = nil)
    section ||= 'processes'
    SidekiqStatus::View.new.display(section)
  rescue View::InvalidSection => e
    puts e.message
  rescue View::NoProcessFound => e
    puts e.message
    # THIS IS the CRUNCHY bit
    # and what we really need to implement
    # or let them all fail i guess
    # we should probably detect that sidekiq server isn't running as a first port of call
    # then look at other error modes
    # TODO: isolate known failure modes, redis unavailable, etc
    #   NOTE: avoid swallowing all errors here
  #     rescue RedisError, ETC => e
    #     puts "Couldn't get status: #{e}"
    #     exit 1
  end
end
