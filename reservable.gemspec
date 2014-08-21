$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "reservable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "reservable"
  s.version     = Reservable::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Reservable."
  s.description = "TODO: Description of Reservable."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.1.5"

  s.add_development_dependency "pg"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency 'shoulda-matchers'

end
