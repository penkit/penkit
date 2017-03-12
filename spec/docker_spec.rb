describe Penkit::Docker do
  let(:lines) { [] }
  before do
    allow(subject).to receive(:exec).and_return(true)
    allow(subject).to receive(:system).and_return(true)
    allow(IO).to receive(:popen).and_return(double(:io, readlines: lines))
  end

  describe "#create_network!" do
    let(:command) { %w(docker network create --driver bridge penkit) }
    let(:options) { { out: File::NULL } }

    context "when network exists" do
      before { allow(subject).to receive(:network_exists?).and_return(true) }

      it "does nothing" do
        expect(subject).not_to receive(:system)
        subject.create_network!
      end
    end

    context "when network does not exist" do
      before { allow(subject).to receive(:network_exists?).and_return(false) }

      it "calls docker network create" do
        expect(subject).to receive(:system).once.with(*command, options)
        subject.create_network!
      end
    end
  end

  describe "#find_all_containers" do
    let(:command) { %w(docker ps -aq --filter label=penkit) }

    context "without output" do
      let(:lines) { [] }

      it "returns empty array" do
        expect(IO).to receive(:popen).once.with(command)
        expect(subject.find_all_containers).to eq([])
      end
    end

    context "with output" do
      let(:lines) { ["a\n", "b\n", "c\n"] }

      it "returns array of lines" do
        expect(IO).to receive(:popen).once.with(command)
        expect(subject.find_all_containers).to eq(%w(a b c))
      end
    end
  end

  describe "#find_running_containers" do
    let(:command) { %w(docker ps -q --filter label=penkit) }

    context "without output" do
      let(:lines) { [] }

      it "returns empty array" do
        expect(IO).to receive(:popen).once.with(command)
        expect(subject.find_running_containers).to eq([])
      end
    end

    context "with output" do
      let(:lines) { ["a\n", "b\n", "c\n"] }

      it "returns array of lines" do
        expect(IO).to receive(:popen).once.with(command)
        expect(subject.find_running_containers).to eq(%w(a b c))
      end
    end
  end
  
  describe "#ps" do
    let(:command) { %w(docker ps --filter label=penkit) }

    it "calls docker ps" do
      expect(subject).to receive(:exec).once.with(*command)
      subject.ps
    end
  end
  
  describe "#rm" do
    let(:command) { %w(docker rm --force) }

    it "calls docker rm" do
      expect(subject).to receive(:exec).once.with(*command, :a, :b, :c)
      subject.rm(:a, :b, :c)
    end
  end

  describe "#run" do
    let(:command) { %w(docker run --rm -it --label penkit=true --network penkit) }

    it "calls docker run" do
      expect(subject).to receive(:create_network!).ordered
      expect(subject).to receive(:exec).ordered.with(*command, "penkit/cli:example", :a, :b, :c)
      subject.run("cli:example", :a, :b, :c)
    end
  end

  describe "#start" do
    context "without arguments" do
      let(:command) { %w(docker run --detach --label penkit=true --network penkit --name rails --hostname rails) }
      let(:options) { {} }

      it "calls docker run with defaults" do
        expect(subject).to receive(:create_network!).ordered
        expect(subject).to receive(:unique_name).ordered.with("rails:latest").and_return("rails")
        expect(subject).to receive(:puts).ordered.with("Starting container rails")
        expect(subject).to receive(:exec).ordered.with(*command, "penkit/rails:latest")
        subject.start("rails:latest", options)
      end
    end

    context "with --name" do
      let(:command) { %w(docker run --detach --label penkit=true --network penkit --name custom --hostname custom) }
      let(:options) { { name: "custom" } }

      it "calls docker run with custom name" do
        expect(subject).to receive(:create_network!).ordered
        expect(subject).not_to receive(:unique_name)
        expect(subject).to receive(:puts).ordered.with("Starting container custom")
        expect(subject).to receive(:exec).ordered.with(*command, "penkit/rails:latest")
        subject.start("rails:latest", options)
      end
    end
  end

  describe "#stop" do
    let(:command) { %w(docker stop) }

    it "calls docker stop" do
      expect(subject).to receive(:exec).once.with(*command, :a, :b, :c)
      subject.stop(:a, :b, :c)
    end
  end

  # private

  describe "#network_exists?" do
    let(:command) { %w(docker network inspect penkit) }
    let(:options) { { out: File::NULL, err: File::NULL } }

    it "calls docker network inspect" do
      expect(subject).to receive(:system).with(*command, options).and_return(:network_status)
      expect(subject.send(:network_exists?)).to eq(:network_status)
    end
  end
end
