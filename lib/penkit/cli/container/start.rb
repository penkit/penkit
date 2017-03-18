module Penkit
  class CLI < Thor
    desc "start [OPTIONS] IMAGE", "Start a penkit docker image"
    option :name, desc: "Override name and hostname of container"
    def start(image)
      if has_config?(image)
        opts = options.dup
        opts[:name] ||= unique_name(image)
        docker_compose.up(image, opts)
      else
        docker.start(image, options.dup)
      end
    end
  end
end
