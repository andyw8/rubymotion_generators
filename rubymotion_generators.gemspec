# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rubymotion_generators/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Andy Waite"]
  gem.email         = ["github.aw@andywaite.com"]
  gem.description   = "RubyMotion generators"
  gem.summary       = "RubyMotion generators"
  gem.homepage      = "https://github.com/andyw8/rubymotion_generators"

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rubymotion_generators"
  gem.require_paths = ["lib"]
  gem.version       = RubymotionGenerators::VERSION
  gem.extensions    = ['ext/extconf.rb'] # Command-Line Plugin Installer

  gem.add_dependency('thor', '~> 0.15')
  gem.add_development_dependency('aruba', '~> 0.4')
end
