require "test_helper"

class OverrideCallbackTest < ActiveSupport::TestCase
	def test_adept_scale_active_job_enqueue
		out, err = capture_subprocess_io do
			BasicProcessJob.perform_later( 1 )
		end
		assert_match /^.*ADEPT_SCALE JOB_QUEUED.*$/, out
		assert_empty err
	end

	def test_adept_scale_active_job_process
		out, err = capture_subprocess_io do
			BasicProcessJob.perform_now( 1 )
		end
		#We should note it is starting
		assert_match /^.*ADEPT_SCALE JOB_STARTING.*$/, out
		#we should note when it completes
		assert_match /^.*ADEPT_SCALE JOB_COMPLETE.*$/, out
		assert_empty err
	end

	def test_adept_scale_active_job_exception
		#first test we are outputting the message
		out, err = capture_subprocess_io do
			#This should raise an exception as normal
			assert_raises Exception do
				BasicProcessJob.perform_now( nil )
			end
		end
		#this should also let us know that we failed
		assert_match /^.*ADEPT_SCALE JOB_FAILED.*$/, out
	end
end
