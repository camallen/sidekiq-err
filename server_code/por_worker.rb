# frozen_string_literal: true

require 'sidekiq'

# Start up sidekiq via
# bundle exec sidekiq -r ./server_code/por_worker.rb
#
# https://github.com/mperham/sidekiq/blob/acaee69ba4ac99174afba7098e703bda9bb53339/examples/por.rb
class PlainOldRuby
  include Sidekiq::Worker

  def perform(how_hard = 'super hard', how_long = 1)
    sleep how_long
    puts "Workin' #{how_hard}"
  end
end

# schedule some jobs to run in the worker above so we have someting to report
10.times do |num|
  PlainOldRuby.perform_async('9 to 5', num)
end
