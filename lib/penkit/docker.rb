module Penkit
  class Docker
    IMAGE_REGEX = /^([^\s\/:]+)(:[^\s\/:]+)?$/
    NETWORK = "penkit".freeze
    REPOSITORY = "penkit".freeze

    def create_network!
      system("docker", "network", "create", *network_options, out: File::NULL) unless network_exists?
    end

    def find_all_containers
      IO.popen(["docker", "ps", "-aq", *filter_options]).readlines.map(&:strip)
    end

    def find_running_containers
      IO.popen(["docker", "ps", "-q", *filter_options]).readlines.map(&:strip)
    end

    def image_name(image)
      image[IMAGE_REGEX, 1]
    end

    def image_url(image)
      "#{REPOSITORY}/#{image}"
    end

    def ps
      exec("docker", "ps", *filter_options)
    end

    def rm(*containers)
      exec("docker", "rm", "--force", *containers)
    end

    def run(image, *args)
      create_network!
      exec("docker", "run", "--rm", "-it", *run_options, image_url(image), *args)
    end

    def start(image, options={})
      create_network!
      options[:name] ||= unique_name(image)
      puts "Starting container #{options[:name]}"
      exec("docker", "run", "--detach", *run_options(options), image_url(image))
    end

    def stop(*containers)
      exec("docker", "stop", *containers)
    end

    def unique_name(name)
      name = image_name(name)
      name_list = find_container_names
      100.times do |i|
        return name unless name_list.include? name
        name = [name[/^(.*\D)\d*$/, 1], i + 1].join
      end
      name
    end

    private

    def find_container_names
      IO.popen(["docker", "ps", "-a", "--format", "{{.Names}}", *filter_options]).readlines.map(&:strip)
    end

    def network_exists?
      system("docker", "network", "inspect", NETWORK, out: File::NULL, err: File::NULL)
    end

    def network_options
      %w(--driver bridge) << NETWORK
    end

    def filter_options
      %w(--filter label=penkit)
    end

    def run_options(options={})
      args = %w(--label penkit=true --network penkit)
      args += ["--name", options[:name], "--hostname", options[:name]] if options[:name]
      args
    end
  end
end
