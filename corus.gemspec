# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "corus/version"

Gem::Specification.new do |s|
  s.name        = "corus"
  s.version     = Corus::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Duncan Grazier"]
  s.email       = ["duncan@impossiblerocket.com"]
  s.homepage    = "https://github.com/itsmeduncan/corus"
  s.summary     = %q{Define what is not nullable related to an ActiveRecord backed class}
  s.description = %q{Use this gem to define what is not nullable related to an ActiveRecord backed class}

  s.rubyforge_project = "corus"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency("rake", "~> 13.0.6")
  s.add_development_dependency("rspec", ["~> 2.6.0"])
  s.add_development_dependency("mocha", ["~> 0.9.12"])
  s.add_development_dependency("sqlite3", ["~> 1.3.3"])

  s.add_dependency("activerecord", ["~> 2.3.12"])
end
