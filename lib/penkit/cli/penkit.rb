require "thor"

module Penkit
  class CLI < Thor
    desc "ps", "List penkit docker containers"
    def ps
      Penkit::Docker.new.ps
    end

    desc "rm [CONTAINER...]", "Remove penkit docker containers"
    def rm(*containers)
      if containers.any?
        Penkit::Docker.new.rm(*containers)
      else
        Penkit::Docker.new.rm_all
      end
    end

    desc "start IMAGE", "Start penkit docker image"
    def start(image)
      Penkit::Docker.new.start(image)
    end

    desc "stop [CONTAINER...]", "Stop penkit docker containers"
    def stop(*containers)
      if containers.any?
        Penkit::Docker.new.stop(*containers)
      else
        Penkit::Docker.new.stop_all
      end
    end
  end
end
