require "thor"

module Penkit
  class CLI < Thor
    desc "curl [ARGS...]", "Run curl on the penkit docker network"
    def curl(*args)
      docker.run("cli:curl", *args)
    end

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
  end
end
