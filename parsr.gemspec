# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "parsr"

Gem::Specification.new do |s|
  s.name        = "parsr"
  s.version     = Parsr::VERSION
  s.authors     = ["Jean Boussier"]
  s.email       = ["jean.boussier@gmail.com"]
  s.homepage    = "https://github.com/byroot/parsr/"
  s.summary     = %q{Simple parser to safe eval ruby literals}
  s.description = %q{Parsr aim to provide a way to safely evaluate a ruby expression composed only with literals, just as Python's ast.literal_eval}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
end
