# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec_rails_routing/version'

Gem::Specification.new do |spec|
  spec.name          = "rspec-rails-routing"
  spec.version       = Rspec::Rails::Routing::VERSION
  spec.authors       = ["C. Jason Harrelson"]
  spec.email         = ["jason@lookforwardenterprises.com"]
  spec.description   = %q{Rspec matchers for Rails routing.}
  spec.summary       = %q{Rspec matchers for Rails routing.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "rspec", "~> 3"
end
