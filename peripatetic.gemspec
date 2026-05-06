# -*- encoding: utf-8 -*-
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'peripatetic/version'

Gem::Specification.new do |gem|
  gem.name          = "peripatetic"
  gem.version       = Peripatetic::VERSION
  gem.authors       = ["Scott Smith"]
  gem.email         = ["scottsmit@gmail.com"]
  gem.description   = "Drop-in Location Management for Rails models with geocoding support"
  gem.summary       = "Any model can have locations with nested forms and geocoding capabilities"
  gem.homepage      = "https://github.com/davingee/Peripatetic"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.require_paths = ["lib"]

  # Rails 8.x+ support
  gem.add_dependency "rails", ">= 8.0"
  gem.add_dependency "geocoder", ">= 1.8.0"
  gem.add_dependency "activemodel", ">= 8.0"
  gem.add_dependency "activerecord", ">= 8.0"

  # Development dependencies
  gem.add_development_dependency "rspec", "~> 3.13"
  gem.add_development_dependency "sqlite3", "~> 2.0"
  gem.add_development_dependency "rake", "~> 13.0"
end
