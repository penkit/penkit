module Penkit
  class DockerCompose
    def has_config?(image)
      File.exist?(config_file(image))
    end

    def up(image, options = {})
      docker.create_network!
      env = compose_env(image, options)

      # TODO: find out why exec bombs here (see Penkit::Docker#find_all_containers)
      system(env, "docker-compose", *compose_options(image, options), "up", "-d")
    end

    private

    def compose_env(image, options={})
      {
        "DOCKER_IMAGE" => docker.image_url(image),
        "DOCKER_NAME" => options[:name]
      }
    end

    def compose_options(image, options={})
      ["-f", config_file(image), "-p", options[:name]]
    end

    def config_file(image)
      root = File.expand_path("../../..", __FILE__)
      File.join(root, "config", "#{docker.image_name(image)}.yml")
    end

    def docker
      @docker ||= Penkit::Docker.new
    end
  end
end
