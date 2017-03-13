module Penkit
  class Docker
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

    private

    def run_options(options={})
      args = %w(--label penkit=true --network penkit)
      args += ["--name", options[:name], "--hostname", options[:name]] if options[:name]
      args
    end
  end
end
