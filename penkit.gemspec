$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "penkit/version"

Gem::Specification.new do |s|
  s.name = "penkit"
  s.version = Penkit::VERSION
  s.date = "2017-03-03"
  s.summary = "Penkit CLI"
  s.description = "Command-line interface for managing Penkit containers"
  s.authors = ["Don Humphreys", "Sam Lachance"]
  s.email = ["don@penkit.io", "sam@penkit.io"]
  s.homepage = "http://penkit.io"
  s.license = "MIT"

  s.add_dependency "thor", "~> 0.19.4"
  s.add_development_dependency "rspec", "~> 3.5"

  s.bindir = "bin"
  s.files = Dir["{bin,lib}/**/*"] + ["LICENSE"]
  s.executables = %w(penkit)
end
