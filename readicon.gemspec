$:.push File.expand_path("../lib", __FILE__)
require "readicon/version"

Gem::Specification.new do |s|
  s.name        = "readicon"
  s.version     = Readicon::VERSION.dup
  s.platform    = Gem::Platform::RUBY 
  s.summary     = "Simple tracking of arbitrary items by users"
  s.email       = "adam.bird@gmail.com"
  s.homepage    = "http://github.com/adambird/readicon"
  s.description = "Simple tracking of arbitrary items by users"
  s.authors     = ['Adam Bird']

  s.files         = Dir["lib/**/*"]
  s.test_files    = Dir["spec/**/*"]
  s.require_paths = ["lib"]

  s.add_dependency('mongo', '~> 1.6')
  s.add_dependency('bson_ext', '~> 1.6')
end