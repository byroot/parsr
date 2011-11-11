# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "parsr"

Gem::Specification.new do |s|
  s.name        = "parsr"
  s.version     = Parsr::VERSION
  s.authors     = ["Jean Boussier"]
  s.email       = ["jean.boussier@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Simple parser to safe eval ruby literals}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
end
