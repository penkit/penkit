module Penkit
  class CLI < Thor
    desc "pull IMAGE", "Pull most recent version of an image"
    def pull(image)
      docker.pull(image)
    end
  end
end
