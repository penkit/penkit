describe Penkit::DockerCompose do
  stub_docker!
  stub_system_calls!

  it "includes helpers" do
    expect(subject).to be_a(Penkit::Helpers)
  end

  describe "#up" do
    let(:env) { { "DOCKER_IMAGE" => "penkit/rails:latest", "DOCKER_NAME" => "custom2" } }
    let(:command) { %w(docker-compose -f path/to/rails.yml -p custom2 up -d) }
    let(:options) { { name: "custom2" } }

    it "calls docker-compose up" do
      expect(docker).to receive(:create_network!).ordered
      expect(subject).to receive(:config_file).ordered.with("rails:latest").and_return("path/to/rails.yml")
      expect(subject).to receive(:system).ordered.with(env, *command)
      subject.up("rails:latest", options)
    end
  end
end
