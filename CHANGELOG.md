# Change Log

All notable changes to Penkit will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

### Added

- Additional arguments to `ps` command are forwarded to docker.
- New `--force` option for `stop` and `rm` commands.
- New `pull` command that pulls the latest version of target image.
- Config file for running `php` sql injection application with mysql.

### Changed

- The `start` command now automatically pulls latest version of target image.

### Fixed

- Keep `wpscan` command from prompting user to update wpscan database.

## [0.0.1] - 2017-03-18

### Added

- New `version` command that prints current penkit version.
- New tool commands: `ftp`, `netcat`, `nmap`, `ping`, `rpcinfo`, `showmount`, `smbclient`, and `wget`.
- Added several badges and "quick install" guide to README.

### Changed

- Incorporated `curl` tool into new multi-use `net` tool.
- Replaced `penkit/cli:curl` image with `penkit/cli:net`.
- Refactored CLI into more manageable classes and specs.
- Changed copy in install instructions from `http` to `https`.

### Fixed

- Added missing package `nmap-scripts` for version detection.
- Restricted Ruby version to `>= 1.9.0` in gemspec

## [0.0.1.rc2] - 2017-03-12

### Fixed

- Removed hard-coded date in gemspec.

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

[Unreleased]: https://gitlab.com/penkit/penkit/compare/v0.0.1...master
[0.0.1]: https://gitlab.com/penkit/penkit/compare/v0.0.1.rc2...v0.0.1
[0.0.1.rc2]: https://gitlab.com/penkit/penkit/compare/v0.0.1.rc1...v0.0.1.rc2
