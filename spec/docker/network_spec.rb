describe Penkit::Docker do
  stub_system_calls!

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
