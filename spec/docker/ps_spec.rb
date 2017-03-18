describe Penkit::Docker do
  stub_system_calls!

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

  describe "#find_container_names" do
    let(:command) { %w(docker ps -a --format {{.Names}} --filter label=penkit) }

    context "without output" do
      let(:lines) { [] }

      it "returns empty array" do
        expect(IO).to receive(:popen).once.with(command)
        expect(subject.find_container_names).to eq([])
      end
    end

    context "with output" do
      let(:lines) { ["a\n", "b\n", "c\n"] }

      it "returns array of lines" do
        expect(IO).to receive(:popen).once.with(command)
        expect(subject.find_container_names).to eq(%w(a b c))
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
    let(:command) { %w(docker ps --filter label=penkit -s -q) }

    it "calls docker ps" do
      expect(subject).to receive(:exec).once.with(*command)
      subject.ps("-s", "-q")
    end
  end
end
