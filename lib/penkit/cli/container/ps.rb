module Penkit
  class CLI < Thor
    desc "ps [ARGS...]", "List penkit docker containers"
    def ps(*args)
      docker.ps(*args)
    end
  end
end
