$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "reservable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "reservable"
  s.version     = Reservable::VERSION
  s.authors     = ["Yonah Forst"]
  s.email       = ["yonaforst@hotmail.com"]
  s.homepage    = "http://github.come/joshblour"
  s.summary     = "Reserve any active record object for a day or range of days"
  s.description = "Allows any active record model object (such as a room) be reserved (daily) by any other model object (such as a user or a booking)"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.1"

  s.add_development_dependency "pg"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency 'shoulda-matchers'

end
