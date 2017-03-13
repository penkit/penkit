module Penkit
  class Docker
    def create_network!
      system("docker", "network", "create", *network_options, out: File::NULL) unless network_exists?
    end
    
    private

    def network_exists?
      system("docker", "network", "inspect", NETWORK, out: File::NULL, err: File::NULL)
    end

    def network_options
      %w(--driver bridge) << NETWORK
    end
  end
end
