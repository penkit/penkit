describe Penkit::Docker do
  stub_system_calls!

  describe "#stop" do
    let(:command) { %w(docker stop) }

    it "calls docker stop" do
      expect(subject).to receive(:exec).once.with(*command, :a, :b, :c)
      subject.stop(:a, :b, :c)
    end
  end
end
