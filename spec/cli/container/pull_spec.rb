describe Penkit::CLI do
  stub_docker!

  describe "#pull" do
    it "calls docker#pull" do
      expect(docker).to receive(:pull).once.with("image_name")
      subject.pull("image_name")
    end
  end
end