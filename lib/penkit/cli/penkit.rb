require "thor"
require "penkit/helpers"
require "penkit/cli/container/ps"
require "penkit/cli/container/rm"
require "penkit/cli/container/start"
require "penkit/cli/container/stop"
require "penkit/cli/container/pull"
require "penkit/cli/tools"

module Penkit
  class CLI < Thor
    include Penkit::Helpers

    desc "version", "Show current version"
    def version
      puts VERSION
    end
  end
end
