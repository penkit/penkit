describe Penkit::CLI do
  stub_docker!
  stub_docker_compose!

  describe "#start" do
    let(:options) { {} }
    before { subject.options = options }
    before { allow(subject).to receive(:unique_name).and_return("unique_name") }

    it "prints image pull dialog" do
      expect(docker).to receive(:pull).with("image_name", quiet: true)
      expect(docker).to receive(:start).once.with("image_name", {})
      expect{ subject.start("image_name") }.to output("Pulling latest image...\n").to_stdout
    end

    context "for standard image" do
      before { allow(subject).to receive(:has_config?).and_return(false) }
      
      context "without arguments" do
        it "calls docker#start" do
          allow(subject).to receive(:puts).and_return(true)
          expect(docker).to receive(:pull).with("image_name", quiet: true)
          expect(subject).to receive(:has_config?).once.with("image_name")
          expect(docker_compose).not_to receive(:up)
          expect(docker).to receive(:start).once.with("image_name", {})
          subject.start("image_name")
        end
      end

      context "with --name" do
        let(:options) { { name: "test" } }

        it "calls docker#start" do
          allow(subject).to receive(:puts).and_return(true)
          expect(docker).to receive(:pull).with("image_name", quiet: true)
          expect(subject).to receive(:has_config?).once.with("image_name")
          expect(docker_compose).not_to receive(:up)
          expect(docker).to receive(:start).once.with("image_name", name: "test")
          subject.start("image_name")
        end
      end
    end

    context "for compose image" do
      before { allow(subject).to receive(:has_config?).and_return(true) }

      context "without arguments" do
        it "calls docker_compose#up" do
          allow(subject).to receive(:puts).and_return(true)
          expect(docker).to receive(:pull).with("image_name", quiet: true)
          expect(subject).to receive(:has_config?).once.with("image_name")
          expect(subject).to receive(:unique_name).once.with("image_name")
          expect(docker_compose).to receive(:up).once.with("image_name", name: "unique_name")
          expect(docker).not_to receive(:start)
          subject.start("image_name")
        end
      end

      context "with --name" do
        let(:options) { { name: "test" } }

        it "calls docker_compose#up" do
          allow(subject).to receive(:puts).and_return(true)
          expect(docker).to receive(:pull).with("image_name", quiet: true)
          expect(subject).to receive(:has_config?).once.with("image_name")
          expect(subject).not_to receive(:unique_name)
          expect(docker_compose).to receive(:up).once.with("image_name", name: "test")
          expect(docker).not_to receive(:start)
          subject.start("image_name")
        end
      end
    end
  end
end
