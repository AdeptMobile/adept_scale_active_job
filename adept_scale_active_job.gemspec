$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "adept_scale_active_job/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "adept_scale_active_job"
  s.version     = AdeptScaleActiveJob::VERSION
  s.authors     = ["Alex Burnett"]
  s.email       = [""]
  s.homepage    = "http://adeptscale.com"
  s.summary     = "ActiveJob wrapper for AdeptScale"
  s.description = "Wrapper for ActiveJob to provide tags to STDOUT for use with AdeptScale worker scaling."
  s.license     = "Nonstandard"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 4.2"

  s.add_development_dependency "sqlite3"
end
