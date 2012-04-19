$:.push File.expand_path("../lib", __FILE__)
require "read_tracker/version"

Gem::Specification.new do |s|
  s.name        = "read_tracker"
  s.version     = ReadTracker::VERSION.dup
  s.platform    = Gem::Platform::RUBY 
  s.summary     = "Simple tracking of arbitrary items by users"
  s.email       = "adam.bird@gmail.com"
  s.homepage    = "http://github.com/adambird/read_tracker"
  s.description = "Simple tracking of arbitrary items by users"
  s.authors     = ['Adam Bird']

  s.files         = Dir["lib/**/*"]
  s.test_files    = Dir["spec/**/*"]
  s.require_paths = ["lib"]

  s.add_dependency('mongo', '~> 1.6')
  s.add_dependency('bson_ext', '~> 1.6')
end