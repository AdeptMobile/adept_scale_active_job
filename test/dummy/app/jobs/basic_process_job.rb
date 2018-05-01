#Simulate a job that should run for some period of seconds
class BasicProcessJob < ApplicationJob
	# self.queue_adapter = :sidekiq
	queue_as :worker #:default

	def perform(delay_in_seconds)
		Rails.logger.debug "-------------------------------------------------------------------------------------------"
		begin
			raise "Param missing: delay_in_seconds" if delay_in_seconds.blank?

			time_checker = process_start_time = Time.now
			Rails.logger.debug "BasicProcessJob: TIMER start #{time_checker}"

			Rails.logger.debug "BasicProcessJob: Performing delay (#{delay_in_seconds})"
			sleep( delay_in_seconds.to_f )
			Rails.logger.debug "BasicProcessJob: Delay SUCCESS (#{delay_in_seconds})"

			Rails.logger.info "BasicProcessJob: Processing complete in #{Time.now - process_start_time} seconds"
		rescue Exception => e
			Rails.logger.warn "BasicProcessJob: JOB_DELAYED '#{delay_in_seconds}', #{e.message}"
			raise e #bubble up
		end
	end
end
