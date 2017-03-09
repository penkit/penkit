require "thor"

module Penkit
  class CLI < Thor
    desc "ps", "List penkit docker containers"
    def ps
      docker.ps
    end

    desc "rm [CONTAINER...]", "Remove penkit docker containers"
    def rm(*containers)
      if containers.any?
        docker.rm(*containers)
      else
        rm_all
      end
    end

    desc "start IMAGE", "Start penkit docker image"
    def start(image)
      docker.start(image)
    end

    desc "stop [CONTAINER...]", "Stop penkit docker containers"
    def stop(*containers)
      if containers.any?
        docker.stop(*containers)
      else
        stop_all
      end
    end

    # Tools

    desc "metasploit [ARGS...]", "Run metasploit on the penkit docker network"
    def metasploit(*args)
      docker.run("cli:metasploit", *args)
    end

    desc "sqlmap [ARGS...]", "Run sqlmap on the penkit docker network"
    def sqlmap(*args)
      docker.run("cli:sqlmap", *args)
    end

    desc "wpscan [ARGS...]", "Run wpscan on the penkit docker network"
    def wpscan(*args)
      docker.run("cli:wpscan", *args)
    end

    private

    def docker
      @docker ||= Penkit::Docker.new
    end

    def stop_all
      containers = docker.find_running_containers
      docker.stop(*containers) if stop_all?(containers)
    end

    def stop_all?(containers)
      return false if containers.size == 0
      message = "Are you sure you want to stop %d %s? [y/N]"
      word = containers.size > 1 ? "containers" : "container"
      ask(message % [containers.size, word]) == "y"
    end

    def rm_all
      containers = docker.find_all_containers
      docker.rm(*containers) if rm_all?(containers)
    end

    def rm_all?(containers)
      return false if containers.size == 0
      message = "Are you sure you want to remove %d %s? [y/N]"
      word = containers.size > 1 ? "containers" : "container"
      ask(message % [containers.size, word]) == "y"
    end
  end
end
