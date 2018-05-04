# AdeptScaleActiveJob
Short description and motivation.

## Usage
This plugin extends the `ActiveJob::Base` class in order to insert ADEPT_SCALE tagged logs into your app's STDOUT. The tags include ['JOB_QUEUED', 'JOB_STARTING', 'JOB_COMPLETE', 'JOB_FAILED'] and are used by AdeptScale to keep the current state of your job queue for the purpose of scaling worker dynos.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'adept_scale_active_job'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install adept_scale_active_job
```

## Configuration
After installation, change any ActiveJob based object to inherit from ```AdeptScaleActiveJob::Base``` instead of the default ```AdeptScaleActiveJob::Base```.
For example, the simplest method would be at the ApplicationJob level:
```
# /app/jobs/applicaiton_job.rb

class ApplicationJob < AdeptScaleActiveJob::Base
end
```

## License
Copyright 2018 AdeptLabs INC, All rights reserved.


