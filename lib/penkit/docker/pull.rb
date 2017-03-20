module Penkit
  class Docker
    def pull(image, options={})
      if options[:quiet]
        system("docker", "pull", image_url(image), out: File::NULL, err: File::NULL)
      else
        system("docker", "pull", image_url(image))
      end
    end
  end
end