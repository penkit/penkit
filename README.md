# Penkit

Penkit is a software suite designed for honing your pentesting skills. Using the power and flexibility of docker, we are able to build controlled, isolated environments for reproducing virtually any software vulnerability out there. Penkit has two major components: our strictly maintained image catalog and our full featured CLI application.

## Installation

Penkit has only a couple of requirements and three different install options.

### Prerequisites

- Linux or OSX
- Docker 1.13+
- Ruby and rubygems (optional)

### Option 1: Ruby gem

You can install the penkit gem directly from [rubygems.org](https://rubygems.org/gems/penkit):

```
gem install penkit
penkit help
```

### Option 2: Docker image

If you don't have ruby, then you can use the penkit Docker image:

```bash
docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock penkit/cli help
```

### Option 3: Bash wrapper

If docker commands are a hassle to you, just download our bash wrapper:

```bash
wget -O /usr/local/bin/penkit https://gitlab.com/penkit/penkit/raw/master/scripts/penkit
chmod +x penkit
penkit  help
```

## Usage

WIP: usage

## Testing

WIP: testing

## Contributing

WIP: contributing
