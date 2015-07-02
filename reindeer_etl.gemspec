# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reindeer_etl/version'

Gem::Specification.new do |spec|
  spec.name          = "reindeer_etl"
  spec.version       = ReindeerETL::VERSION
  spec.authors       = ["William Hatt", "Patrick Chung"]
  spec.email         = ["hattb@ohsu.edu", "chungp@ohsu.edu"]

  spec.summary       = %q{A simple ETL pipeline for use with project reindeer and LimeSurvey}
  spec.description   = %q{An ETL pipeline tool for automatic data modifications to LimeSurvey}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  #end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.test_files    = Dir.glob("test/**/*.rb")
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client", "~> 1.8"
  spec.add_development_dependency "minitest", "~> 5.7"
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", "~> 0.10.1"

end
