module Penkit
  class Docker
    def stop(forced, *containers)
      if forced
        exec("docker", "stop", "--time", "0", *containers)
      else
        exec("docker", "stop", *containers)
      end
    end
  end
end
