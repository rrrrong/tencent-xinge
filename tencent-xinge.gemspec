# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tencent/xinge/version'

Gem::Specification.new do |spec|
  spec.name          = "tencent-xinge"
  spec.version       = Tencent::Xinge::VERSION
  spec.authors       = ["yuyu"]
  spec.email         = ["datty258@126.com"]
  spec.summary       = %q{"tencent xinge push"}
  spec.description   = %q{"tencent xinge push"}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
