module Penkit
  class Docker
    def rm(*containers)
      exec("docker", "rm", "--force", *containers)
    end
  end
end
