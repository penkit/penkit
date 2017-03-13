module Penkit
  class CLI < Thor
    desc "stop [CONTAINER...]", "Stop penkit docker containers"
    def stop(*containers)
      if containers.any?
        docker.stop(*containers)
      else
        stop_all
      end
    end

    private

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
  end
end
