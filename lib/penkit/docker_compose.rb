require "penkit/helpers"

module Penkit
  class DockerCompose
    include Penkit::Helpers

    def up(image, options = {})
      docker.create_network!
      env = compose_env(image, options)

      # TODO: find out why exec bombs here (see Penkit::Docker#find_all_containers)
      system(env, "docker-compose", *compose_options(image, options), "up", "-d")
    end

    private

    def compose_env(image, options={})
      {
        "DOCKER_IMAGE" => image_url(image),
        "DOCKER_NAME" => options[:name]
      }
    end

    def compose_options(image, options={})
      ["-f", config_file(image), "-p", options[:name]]
    end
  end
end
