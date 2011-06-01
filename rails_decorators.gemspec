Gem::Specification.new do |s|
  s.name        = "rails_decorators"
  s.version     = "0.2.0"
  s.author      = "Jeff Casimir"
  s.email       = "jeff@jumpstartlab.com"
  s.homepage    = "http://github.com/jcasimir/rails_decorators"
  s.summary     = "Decorator pattern implmentation for Rails."
  s.description = "Rails Decorators reimagines the role of helpers in the view layer of a Rails application, allowing an object-oriented approach rather than procedural."

  s.files        = Dir["{lib,rails_generators}/**/*", "[A-Z]*"]
  s.require_path = "lib"

  s.add_development_dependency 'rspec-rails', '~> 2.0.1'
  s.rubyforge_project = s.name
  s.required_rubygems_version = ">= 1.3.4"
end