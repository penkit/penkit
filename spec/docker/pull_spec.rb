describe Penkit::Docker do
  stub_system_calls!

  describe "#pull" do
    context "without options" do
      it "calls docker pull" do
        expect(subject).to receive(:system).once.with("docker", "pull", "penkit/image")
        subject.pull("image")
      end
    end

    context "with quiet option" do
      it "calls docker pull quietly" do
        expect(subject).to receive(:system).once.with("docker", "pull", "penkit/image", out: File::NULL, err: File::NULL)
        subject.pull("image", quiet: true)
      end
    end
  end
end
