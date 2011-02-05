# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "reportula-vampire/version"

Gem::Specification.new do |s|
  s.name        = "reportula-vampire"
  s.version     = Reportula::Vampire::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["David Vollbracht"]
  s.email       = ["david@flipstone.com"]
  s.homepage    = "http://reportula.com"
  s.summary     = %q{Rack middleware allowing Reportula to suck data out of yoru app}
  s.description = %q{The Reportula Vampire discovers domain models in your application
and exposes their counts via urls like /reportula-vampire/stats/foos/count.  Reportula
harvests these counts on a nightly bases to capture data for it's reporting}

  s.rubyforge_project = "reportula-vampire"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
