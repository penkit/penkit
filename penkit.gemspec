$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "penkit/version"

Gem::Specification.new do |s|
  s.name = "penkit"
  s.version = Penkit::VERSION
  s.summary = "Penkit CLI"
  s.description = "Command-line interface for managing Penkit containers"
  s.authors = ["Don Humphreys", "Sam Lachance"]
  s.email = ["don@penkit.io", "sam@penkit.io"]
  s.homepage = "http://penkit.io"
  s.license = "MIT"

  s.required_ruby_version = ">= 1.9.0"
  s.required_rubygems_version = ">= 1.3.5"

  s.add_dependency "thor", "~> 0.19.4"
  s.add_development_dependency "bundler", "~> 1.0"
  s.add_development_dependency "rspec", "~> 3.5"

  s.bindir = "bin"
  s.files = Dir["{bin,config,lib}/**/*"] + %w(LICENSE TERMS)
  s.executables = %w(penkit)
end
