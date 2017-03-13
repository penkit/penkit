describe Penkit::CLI do
  stub_docker!

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
