# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'modo_payments/api/version'

Gem::Specification.new do |spec|
  spec.name          = "modo_payments-api"
  spec.version       = ModoPayments::API::VERSION
  spec.authors       = ["Chris Hart"]
  spec.email         = ["hartct@gmail.com"]
  spec.summary       = %q{Wrapper for the ModoPayments API.}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.1"
end
