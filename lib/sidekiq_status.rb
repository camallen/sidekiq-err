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
    puts "Usage: #{CMD} <section>"
    puts
    puts '       <section> (optional) view a specific section of the status output'
    puts "       Valid sections are: #{View.valid_sections.join(', ')}"
    puts "       Default is 'processes'"
    puts
  end

  def self.status(section=nil)
    section ||= 'processes'
    SidekiqStatus::View.new.display(section)
  rescue View::InvalidSection => e
    puts e.message
    # TODO: isolate known failure modes, redis unavailable, etc
    # # avoid swallowing all errors here
    # rescue RedisError, ETC => e
    #   puts "Couldn't get status: #{e}"
    #   exit 1
  end
end
