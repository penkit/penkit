describe Penkit::Docker do
  stub_system_calls!

  describe "#pull" do
    it "calls docker pull" do
      expect(subject).to receive(:puts).ordered.with("Pulling latest image...")
      expect(subject).to receive(:`).once.with("docker pull penkit/image")
      subject.pull("image")
    end
  end
end
