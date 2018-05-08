# AdeptScaleActiveJob
Short description and motivation.

## Usage
This plugin extends the `ActiveJob::Base` class in order to insert ADEPT_SCALE tagged logs into your app's STDOUT. The tags include ```['JOB_QUEUED', 'JOB_STARTING', 'JOB_STATUS', 'JOB_COMPLETE', 'JOB_FAILED']``` and are used by AdeptScale to keep the current state of your job queue for the purpose of scaling worker dynos.
More explanation of how these work can be found on our [Documentation](https://devcenter.heroku.com/articles/adept-scale)

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

### Inherit Job Model from AdeptScaleActiveJob
After installation, change any ActiveJob based object to inherit from ```AdeptScaleActiveJob::Base``` instead of the default ```AdeptScaleActiveJob::Base```.
For example, the simplest method would be at the ApplicationJob level:
```
# /app/jobs/applicaiton_job.rb

class ApplicationJob < AdeptScaleActiveJob::Base
end
```

### Procfile
In delivered form this gem assumes that the job queue has the same name as the dyno it runs on. If this is not the case, you will need to make necessary changes to support your particular use case.
Future plans include adding support for a procfile where you can define a mapping between queue names and which dyno types they run on. Contributions in this regard are greatly welcome.

## Contribution

We encourage all contributors and love to hear your feedback. Hopefully this will be a bare-bones example for similar plugins in other languages.

## License
Copyright 2018 AdeptLabs INC, All rights reserved.


