# Change Log

All notable changes to Penkit will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

N/A

## 0.0.1.rc1 - 2017-03-11

### Added

- Basic commands: `help`, `ps`, `start`, `stop`, and `rm`.
- Tool commands: `curl`, `metasploit`, `sqlmap`, `wpscan`
- Added `penkit start --name=name` option for custom container names.
- Docker images for CLI and all tools.
- Docker-compose config file for WordPress image.
- Bash wrapper for running Penkit with Docker.
- RSpec tests for all CLI functionality.
- Gemspec for building and distributing Penkit as a gem.
- Configured GitLab build pipeline for testing gem build and specs.
- README file with installation, usage, and contributing instructions.
- Adopted MIT license for Penkit codebase.

[Unreleased]: https://gitlab.com/penkit/penkit/compare/v0.0.1.rc1...master
