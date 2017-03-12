describe Penkit::DockerCompose do
  let(:docker) { double(:docker) }
  before do
    allow(Penkit::Docker).to receive(:new).and_return(docker)
  end

  let(:lines) { [] }
  before do
    allow(subject).to receive(:exec).and_return(true)
    allow(subject).to receive(:system).and_return(true)
    allow(IO).to receive(:popen).and_return(double(:io, readlines: lines))
  end

  describe "#has_config?" do
    context "when config exists" do
      before { allow(docker).to receive(:image_name).and_return("wordpress") }

      it "returns true" do
        expect(File).to receive(:exist?).once.with(/\/wordpress\.yml$/).and_call_original
        expect(subject.has_config?("wordpress:4.7")).to eq(true)
      end
    end

    context "when config does not exists" do
      before { allow(docker).to receive(:image_name).and_return("missing") }

      it "returns false" do
        expect(File).to receive(:exist?).once.with(/\/missing\.yml$/).and_call_original
        expect(subject.has_config?("missing:latest")).to eq(false)
      end
    end
  end

  describe "#up" do
    let(:env) { { "DOCKER_IMAGE" => "penkit/rails:latest", "DOCKER_NAME" => "custom2" } }
    let(:command) { %w(docker-compose -f path/to/rails.yml -p custom2 up -d) }
    let(:options) { { name: "custom2" } }

    before { allow(docker).to receive(:image_name).and_return("rails") }
    before { allow(docker).to receive(:image_url).and_return("penkit/rails:latest") }

    it "calls docker-compose up" do
      expect(docker).to receive(:create_network!).ordered
      expect(subject).to receive(:config_file).ordered.with("rails:latest").and_return("path/to/rails.yml")
      expect(subject).to receive(:system).ordered.with(env, *command)
      subject.up("rails:latest", options)
    end
  end
end
