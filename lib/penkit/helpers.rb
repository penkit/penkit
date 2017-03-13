module Penkit
  module Helpers
    private

    def config_file(image)
      root = File.expand_path("../../..", __FILE__)
      File.join(root, "config", "#{image_name(image)}.yml")
    end

    def docker
      @docker ||= Penkit::Docker.new
    end

    def docker_compose
      @docker_compose ||= Penkit::DockerCompose.new
    end

    def has_config?(image)
      File.exist?(config_file(image))
    end

    def image_name(image)
      image[Penkit::Docker::IMAGE_REGEX, 1]
    end

    def image_url(image)
      "#{Penkit::Docker::REPOSITORY}/#{image}"
    end

    def unique_name(name)
      name = image_name(name)
      name_list = docker.find_container_names
      99.times do |i|
        return name unless name_list.include? name
        name = [name[/^(.*\D)\d*$/, 1], i + 1].join
      end
      name
    end
  end
end
