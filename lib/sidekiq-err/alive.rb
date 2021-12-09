# frozen_string_literal: true

module SidekiqErr
  class Alive
    def self.check?(hostname)
      process_set = Sidekiq::ProcessSet.new
      # now search for the provided process name in the process set
      found_process = process_set.find do |process|
        # we compare the process hostname here as we can know this from k8s land pod
        # and can use the $HOSTNAME env var in the probe command in the probe specification
        #
        # https://stackoverflow.com/questions/58800495/get-a-kubernetes-pods-full-id-from-inside-of-itself-running-container
        # Note: this aligns to 1 sidekiq container process per pod
        #         this may not hold true in some deployments but should work for most use cases
        #         it's preferable to use pod auto scaling vs running multiple containers in a pod
        process['hostname'] == hostname
      end

      raise(NoProcessFound, "No sidekiq process found for hostname: #{hostname}") unless found_process
    end
  end
end