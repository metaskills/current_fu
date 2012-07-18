$:.push File.expand_path("../lib", __FILE__)
require "current_fu/version"

Gem::Specification.new do |s|
  s.name          = 'current_fu'
  s.version       = CurrentFu::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ['Ken Collins']
  s.email         = ['ken@metaskills.net']
  s.homepage      = 'http://github.com/metaskills/current_fu/'
  s.summary       = 'The most evil gem you will hate to love.'
  s.description   = 'CurrentFu gives a standard interface to the current controller instance in your models with automatic delegation to #current_* named methods.'
  s.files         = `git ls-files`.split("\n") - ["current_fu.gemspec"]
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  s.rdoc_options  = ['--charset=UTF-8']
  s.add_runtime_dependency     'rails',     '~> 3.0'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'm'
end
