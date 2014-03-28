# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'factories/version'

Gem::Specification.new do |spec|
  spec.name          = "factories"
  spec.version       = Factories::VERSION
  spec.authors       = ["Nathan Herald"]
  spec.email         = ["me@nathanherald.com"]
  spec.description   = %q{Objects to build and create models}
  spec.summary       = %q{Super simple way to use build(:author) or create(:book) in your tests.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "inflecto"
end
