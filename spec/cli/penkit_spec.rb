describe Penkit::CLI do
  let(:docker) { double(:docker, unique_name: "unique_name") }
  let(:docker_compose) { double(:docker_compose) }
  before do
    allow(Penkit::Docker).to receive(:new).and_return(docker)
    allow(Penkit::DockerCompose).to receive(:new).and_return(docker_compose)
  end

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
  end

  it "is a thor CLI" do
    expect(subject).to be_a(Thor)
  end

  describe "#ps" do
    it "calls docker#ps" do
      expect(docker).to receive(:ps).once.with(no_args)
      subject.ps
    end
  end

  describe "#rm" do
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

  describe "#start" do
    context "for standard image" do
      before { allow(docker_compose).to receive(:has_config?).and_return(false) }

      context "without arguments" do
        it "calls docker#start" do
          expect(docker_compose).to receive(:has_config?).once.with("image_name")
          expect(docker_compose).not_to receive(:up)
          expect(docker).to receive(:start).once.with("image_name", {})
          Penkit::CLI.start(%w(start image_name))
        end
      end

      context "with --name" do
        it "calls docker#start" do
          expect(docker_compose).to receive(:has_config?).once.with("image_name")
          expect(docker_compose).not_to receive(:up)
          expect(docker).to receive(:start).once.with("image_name", name: "test")
          Penkit::CLI.start(%w(start image_name --name test))
        end
      end
    end

    context "for compose image" do
      before { allow(docker_compose).to receive(:has_config?).and_return(true) }

      context "without arguments" do
        it "calls docker_compose#up" do
          expect(docker_compose).to receive(:has_config?).once.with("image_name")
          expect(docker_compose).to receive(:up).once.with("image_name", name: "unique_name")
          expect(docker).not_to receive(:start)
          Penkit::CLI.start(%w(start image_name))
        end
      end

      context "with --name" do
        it "calls docker_compose#up" do
          expect(docker_compose).to receive(:has_config?).once.with("image_name")
          expect(docker_compose).to receive(:up).once.with("image_name", name: "test")
          expect(docker).not_to receive(:start)
          Penkit::CLI.start(%w(start image_name --name test))
        end
      end
    end
  end

  describe "#stop" do
    context "without arguments" do
      before { allow(docker).to receive(:find_running_containers).and_return(containers) }
      before { allow(subject).to receive(:ask).and_return(user_input) }
      let(:method) { :stop }
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
        let(:message) { "Are you sure you want to stop 1 container? [y/N]" }
        include_examples "batch confirmation"
      end

      context "given multiple containers" do
        let(:containers) { [:a, :b, :c] }
        let(:message) { "Are you sure you want to stop 3 containers? [y/N]" }
        include_examples "batch confirmation"
      end
    end

    context "with arguments" do
      it "calls docker#stop" do
        expect(docker).to receive(:stop).once.with(:a, :b, :c)
        subject.stop(:a, :b, :c)
      end
    end
  end

  # Tools

  describe "#curl" do
    it "calls docker#run with arguments" do
      expect(docker).to receive(:run).once.with("cli:curl", :a, :b, :c)
      subject.curl(:a, :b, :c)
    end
  end

  describe "#metasploit" do
    it "calls docker#run with arguments" do
      expect(docker).to receive(:run).once.with("cli:metasploit", :a, :b, :c)
      subject.metasploit(:a, :b, :c)
    end
  end

  describe "#sqlmap" do
    it "calls docker#run with arguments" do
      expect(docker).to receive(:run).once.with("cli:sqlmap", :a, :b, :c)
      subject.sqlmap(:a, :b, :c)
    end
  end

  describe "#metasploit" do
    it "calls docker#run with arguments" do
      expect(docker).to receive(:run).once.with("cli:wpscan", :a, :b, :c)
      subject.wpscan(:a, :b, :c)
    end
  end
end
