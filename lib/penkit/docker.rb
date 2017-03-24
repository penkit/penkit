require "penkit/helpers"
require "penkit/docker/network"
require "penkit/docker/ps"
require "penkit/docker/rm"
require "penkit/docker/start"
require "penkit/docker/stop"
require "penkit/docker/pull"

module Penkit
  class Docker
    include Penkit::Helpers

    IMAGE_REGEX = /^([^\s\/:]+)(:[^\s\/:]+)?$/
    NETWORK = "penkit".freeze
    REPOSITORY = "penkit".freeze
  end
end
