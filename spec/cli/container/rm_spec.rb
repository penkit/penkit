describe Penkit::CLI do
  stub_docker!

  shared_examples "batch confirmation" do
    context "with response of yes" do
      let(:user_input) { "y" }

      it "performs bulk action" do
        expect(subject).to receive(:ask).once.with(message)
        expect(docker).to receive(method).once.with(*containers)
        subject.send(method)
      end
    end

    context "with response of no" do
      let(:user_input) { "n" }

      it "does not perform bulk action" do
        expect(subject).to receive(:ask).once.with(message)
        expect(docker).not_to receive(method)
        subject.send(method)
      end
    end

    context "with blank response" do
      let(:user_input) { "" }

      it "does not perform bulk action" do
        expect(subject).to receive(:ask).once.with(message)
        expect(docker).not_to receive(method)
        subject.send(method)
      end
    end

    context "with --force" do
      let(:options) { { force: true } }

      it "does not prompt before bulk action" do
        expect(subject).not_to receive(:ask)
        expect(docker).to receive(method).once.with(*containers)
        subject.send(method)
      end
    end
  end

  describe "#rm" do
    let(:options) { {} }
    before { subject.options = options }

    context "without arguments" do
      before { allow(docker).to receive(:find_all_containers).and_return(containers) }
      before { allow(subject).to receive(:ask).and_return(user_input) }
      let(:method) { :rm }
      let(:user_input) { nil }

      context "given 0 containers" do
        let(:containers) { [] }

        it "does not perform bulk action" do
          expect(subject).not_to receive(:ask)
          expect(docker).not_to receive(method)
          subject.send(method)
        end
      end

      context "given 1 container" do
        let(:containers) { [:a] }
        let(:message) { "Are you sure you want to remove 1 container? [y/N]" }
        include_examples "batch confirmation"
      end

      context "given multiple containers" do
        let(:containers) { [:a, :b, :c] }
        let(:message) { "Are you sure you want to remove 3 containers? [y/N]" }
        include_examples "batch confirmation"
      end
    end

    context "with arguments" do
      it "calls docker#rm" do
        expect(docker).to receive(:rm).once.with(:a, :b, :c)
        subject.rm(:a, :b, :c)
      end
    end
  end
end
