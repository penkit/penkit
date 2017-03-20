module Penkit
  class Docker
    def find_all_containers
      IO.popen(["docker", "ps", "-aq", *filter_options]).readlines.map(&:strip)
    end

    def find_container_names
      IO.popen(["docker", "ps", "-a", "--format", "{{.Names}}", *filter_options]).readlines.map(&:strip)
    end

    def find_running_containers
      IO.popen(["docker", "ps", "-q", *filter_options]).readlines.map(&:strip)
    end

    def ps(*args)
      exec("docker", "ps", *filter_options, *args)
    end

    private

    def filter_options
      %w(--filter label=penkit)
    end
  end
end
