# -*- encoding: utf-8 -*-
require File.expand_path('../lib/a2z/version', __FILE__)

Gem::Specification.new do |gem|
  gem.author        = 'Matt Huggins'
  gem.email         = 'matt.huggins@gmail.com'
  gem.description   = 'Ruby DSL for Amazon Product Advertising API'
  gem.summary       = 'Ruby DSL for Amazon Product Advertising API'
  gem.homepage      = 'https://github.com/mhuggins/a2z'
  
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'a2z'
  gem.require_path  = 'lib'
  gem.version       = A2z::VERSION
  
  gem.add_dependency 'crack'
  gem.add_dependency 'jeff'
  gem.add_dependency 'money'
  
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
