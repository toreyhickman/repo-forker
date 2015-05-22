# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'repo_forker/version'

Gem::Specification.new do |spec|
  spec.name          = "repo_forker"
  spec.version       = RepoForker::VERSION
  spec.authors       = ["Torey Hickman"]
  spec.email         = ["torey@toreyhickman.com"]
  spec.summary       = "Fork a list of repositories."
  spec.description   = "This gem facilitates forking multiple repositories from one organization/user to another"
  spec.homepage      = "https://github.com/toreyhickman/repo-forker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
end
