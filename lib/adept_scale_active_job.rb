module AdeptScaleActiveJob 
	class Base < ActiveJob::Base
		rescue_from Exception, :with => :log_exception

		def adept_scale_logger
			@@adept_scale_logger ||= Logger.new(STDOUT)
		end

		#@param BasicProcessJob | [@job_id, @queue_name, @priority, @executions, @scheduled_at, @provider_job_id]
		after_enqueue do |job|
			adept_scale_logger.add(6, "ADEPT_SCALE JOB_QUEUED #{build_params job}")
		end

		#@param BasicProcessJob | [@job_id, @queue_name, @priority, @executions, @scheduled_at, @provider_job_id]
		before_perform do |job|
			adept_scale_logger.add(6, "ADEPT_SCALE JOB_STARTING #{build_params job}")
		end

		#@param BasicProcessJob | [@job_id, @queue_name, @priority, @executions, @scheduled_at, @provider_job_id]
		after_perform do |job|
			adept_scale_logger.add(6, "ADEPT_SCALE JOB_COMPLETE #{build_params job}")
		end

	private
		#Catch all Object level base Exceptions, if we can, so we can remove them from the running process list
		def log_exception e
			adept_scale_logger.add(6, "ADEPT_SCALE JOB_FAILED")
			#reraise so as to hopefully not interefere with other error handling
			raise e
		end

		#@param BasicProcessJob | [@job_id, @queue_name, @priority, @executions, @scheduled_at, @provider_job_id]
		#ie. #<BasicProcessJob:0x00007fd0218ab3a0 @arguments=[30], @job_id="4970c4ee-67b7-4cf6-9519-f1bc4513fa4b", @queue_name="worker", @priority=nil, @executions=0, @scheduled_at=1525461719.492488, @provider_job_id="1da86e157a6cd6dc21791b38">
		def build_params job
			#For now we will assume the queue_name is also the dyno type.
			#TODO: either figure out how to obtain the queue_name->dyno_type mapping from config, or build an initializer for the user to set it themselves
			"dyno_type=#{job.queue_name} job_id=#{job.job_id} scheduled_at=#{job.scheduled_at}"
		end
	end
end
