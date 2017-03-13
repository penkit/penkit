module Penkit
  class CLI < Thor
    desc "ps", "List penkit docker containers"
    def ps
      docker.ps
    end
  end
end
