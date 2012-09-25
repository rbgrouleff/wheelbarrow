# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wheelbarrow/version'

Gem::Specification.new do |gem|
  gem.name          = "Wheelbarrow"
  gem.version       = Wheelbarrow::VERSION
  gem.authors       = ["Rasmus Bang Grouleff"]
  gem.email         = ["rasmus@nerdd.dk"]
  gem.description   = %q{Automatic deployment of Ruby on Rails apps when pushing to a Git repo}
  gem.summary       = %q{Automating the deployment procedure of Ruby on Rails apps - just push the app to a Git repo, and Wheelbarrow takes care of the rest.}
  gem.homepage      = "https://github.com/rbgrouleff/wheelbarrow"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
