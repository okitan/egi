# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "egi"

Gem::Specification.new do |s|
  s.name        = "egi"
  s.version     = Egi::VERSION
  s.authors     = ["okitan"]
  s.email       = ["okitakunio@gmail.com"]
  s.homepage    = "http://github.com/okitan/egi"
  s.summary     = %q{manage multi-environments}
  s.description = %q{manage multi-environments}

  s.rubyforge_project = "egi"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  [ [ 'rake' ],
    [ 'rspec' ],
    [ 'autowatchr' ],
  ].each do |gem, version|
    s.add_development_dependency gem, version
  end
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
