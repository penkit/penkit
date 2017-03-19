require "thor"

module Penkit
  class CLI < Thor
    desc "curl [ARGS...]", "Run curl on the penkit docker network"
    def curl(*args)
      docker.run("cli:net", "curl", *args)
    end

    desc "ftp [ARGS...]", "Run ftp on the penkit docker network"
    def ftp(*args)
      docker.run("cli:net", "lftp", *args)
    end

    desc "metasploit [ARGS...]", "Run metasploit on the penkit docker network"
    def metasploit(*args)
      docker.run("cli:metasploit", *args)
    end

    desc "netcat [ARGS...]", "Run netcat on the penkit docker network"
    def netcat(*args)
      docker.run("cli:net", "nc", *args)
    end

    desc "nc [ARGS...]", "Run netcat on the penkit docker network"
    alias_method :nc, :netcat

    desc "nmap [ARGS...]", "Run nmap on the penkit docker network"
    def nmap(*args)
      docker.run("cli:net", "nmap", *args)
    end

    desc "ping [ARGS...]", "Run ping on the penkit docker network"
    def ping(*args)
      docker.run("cli:net", "ping", *args)
    end

    desc "rpcinfo [ARGS...]", "Run rcpinfo on the penkit docker network"
    def rpcinfo(*args)
      docker.run("cli:net", "rpcinfo", *args)
    end

    desc "showmount [ARGS...]", "Run showmount on the penkit docker network"
    def showmount(*args)
      docker.run("cli:net", "showmount", *args)
    end

    desc "smbclient [ARGS...]", "Run smbclient on the penkit docker network"
    def smbclient(*args)
      docker.run("cli:net", "smbclient", *args)
    end

    desc "sqlmap [ARGS...]", "Run sqlmap on the penkit docker network"
    def sqlmap(*args)
      docker.run("cli:sqlmap", *args)
    end

    desc "wget [ARGS...]", "Run wget on the penkit docker network"
    def wget(*args)
      docker.run("cli:net", "wget", *args)
    end

    desc "wpscan [ARGS...]", "Run wpscan on the penkit docker network"
    def wpscan(*args)
      docker.run("cli:wpscan", *args)
    end
  end
end
