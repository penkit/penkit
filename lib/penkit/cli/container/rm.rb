module Penkit
  class CLI < Thor
    desc "rm [CONTAINER...]", "Remove penkit docker containers"
    option :force, desc: "Do not ask to confirm removal", type: :boolean, aliases: "f"
    def rm(*containers)
      if containers.any?
        docker.rm(*containers)
      else
        rm_all
      end
    end

    private

    def rm_all
      containers = docker.find_all_containers
      docker.rm(*containers) if rm_all?(containers)
    end

    def rm_all?(containers)
      return true if options[:force]
      return false if containers.size == 0
      message = "Are you sure you want to remove %d %s? [y/N]"
      word = containers.size > 1 ? "containers" : "container"
      ask(message % [containers.size, word]) == "y"
    end
  end
end
