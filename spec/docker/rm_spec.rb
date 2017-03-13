describe Penkit::Docker do
  stub_system_calls!

  describe "#rm" do
    let(:command) { %w(docker rm --force) }

    it "calls docker rm" do
      expect(subject).to receive(:exec).once.with(*command, :a, :b, :c)
      subject.rm(:a, :b, :c)
    end
  end
end
