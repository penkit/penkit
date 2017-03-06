describe Penkit::CLI do
  let(:docker) { double(:docker) }
  before do
    allow(Penkit::Docker).to receive(:new).and_return(docker)
  end

  it "is a thor CLI" do
    expect(subject).to be_a(Thor)
  end

  # Main

  describe "#ps" do
    it "calls docker#ps" do
      expect(docker).to receive(:ps).once.with(no_args)
      subject.ps
    end
  end

  describe "#rm" do
    context "without arguments" do
      it "calls docker#rm_all" do
        expect(docker).to receive(:rm_all).once.with(no_args)
        subject.rm
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
    it "calls docker#start" do
      expect(docker).to receive(:start).once.with(:image_name)
      subject.start(:image_name)
    end
  end

  describe "#stop" do
    context "without arguments" do
      it "calls docker#stop_all" do
        expect(docker).to receive(:stop_all).once.with(no_args)
        subject.stop
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
