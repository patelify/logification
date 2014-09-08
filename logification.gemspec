# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'logification/version'

Gem::Specification.new do |spec|
  spec.name          = "logification"
  spec.version       = Logification::VERSION
  spec.authors       = ["Nirmit Patel"]
  spec.email         = ["nirmit@patelify.com"]
  spec.summary       = %q{Encourage logging by simplifiying it.}
  spec.description   = %q{Logging made simple}
  spec.homepage      = "http://github.com/patelify/logification"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 0"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "simplecov", "~> 0.7"
  spec.add_development_dependency "codeclimate-test-reporter"

  spec.add_dependency "log4r", "~> 1.1"
  spec.add_dependency "colorize", "~> 0.7"
end
