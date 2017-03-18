describe Penkit::CLI do
  stub_docker!

  describe "#ps" do
    it "calls docker#ps" do
      expect(docker).to receive(:ps).once.with(no_args)
      subject.ps
    end
  end
end
