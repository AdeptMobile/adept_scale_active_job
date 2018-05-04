module AdeptScaleActiveJob 
	class Base < ActiveJob::Base
		rescue_from Exception, :with => :log_exception

		def adept_scale_logger
			@@adept_scale_logger ||= Logger.new(STDOUT)
		end

		after_enqueue do |job|
			adept_scale_logger.add(6, "ADEPT_SCALE JOB_QUEUED dyno_type=#{job.queue_name}")
		end

		before_perform do |job|
			adept_scale_logger.add(6, "ADEPT_SCALE JOB_STARTING")
		end

		after_perform do |job|
			adept_scale_logger.add(6, "ADEPT_SCALE JOB_COMPLETE")
		end

	private
		#Catch all Object level base Exceptions, if we can, so we can remove them from the running process list
		def log_exception e
			adept_scale_logger.add(6, "ADEPT_SCALE JOB_FAILED")
			#reraise so as to hopefully not interefere with other error handling
			raise e
		end

	end
end
