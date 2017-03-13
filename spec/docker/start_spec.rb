describe Penkit::Docker do
  stub_system_calls!

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
end
