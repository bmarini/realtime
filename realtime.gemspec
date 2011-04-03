# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "realtime/version"

Gem::Specification.new do |s|
  s.name        = "realtime"
  s.version     = Realtime::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ben Marini"]
  s.email       = ["bmarini@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/realtime"
  s.summary     = %q{Gem for interacting with the Facebook Real-time Update API}
  s.description = %q{Gem for interacting with the Facebook Real-time Update API}

  s.add_dependency "rack"
  s.add_dependency "koala", "~> 0.9"
  s.add_development_dependency "minitest", "~> 2.0.2"

  s.rubyforge_project = "realtime"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
