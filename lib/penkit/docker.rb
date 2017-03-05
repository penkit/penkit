module Penkit
  class Docker
    NETWORK = "penkit".freeze
    REPOSITORY = "penkit".freeze

    def ps
      exec("docker", "ps", *filter_options)
    end

    def rm(*containers)
      exec("docker", "rm", "--force", *containers)
    end

    def rm_all
      containers = find_all_containers
      rm(*containers) if containers.any?
    end

    def start(image)
      create_network!
      exec("docker", "run", "--detach", *run_options, "#{REPOSITORY}/#{image}")
    end

    def stop(*containers)
      exec("docker", "stop", *containers)
    end

    def stop_all
      containers = find_running_containers
      stop(*containers) if containers.any?
    end

    private

    def create_network!
      system("docker", "network", "create", *network_options, out: File::NULL) unless network_exists?
    end

    def find_all_containers
      IO.popen(["docker", "ps", "-aq", *filter_options]).readlines.map(&:strip)
    end

    def find_running_containers
      IO.popen(["docker", "ps", "-q", *filter_options]).readlines.map(&:strip)
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

    def run_options
      %w(--label penkit=true --network penkit)
    end
  end
end
