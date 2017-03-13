require "thor"
require "penkit/helpers"
require "penkit/cli/container/ps"
require "penkit/cli/container/rm"
require "penkit/cli/container/start"
require "penkit/cli/container/stop"
require "penkit/cli/tools"

module Penkit
  class CLI < Thor
    include Penkit::Helpers
  end
end
