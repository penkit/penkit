module Penkit
  class Docker
    def pull(image)
      puts "Pulling latest image..."
      `docker pull #{image_url(image)}`
    end
  end
end