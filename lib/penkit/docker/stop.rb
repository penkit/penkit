module Penkit
  class Docker
    def stop(*containers)
      exec("docker", "stop", *containers)
    end
  end
end
