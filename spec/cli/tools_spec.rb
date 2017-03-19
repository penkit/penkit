describe Penkit::CLI do
  stub_docker!

  describe "#curl" do
    it "calls docker#run with arguments" do
      expect(docker).to receive(:run).once.with("cli:net", "curl", :a, :b, :c)
      subject.curl(:a, :b, :c)
    end
  end

  describe "#ftp" do
    it "calls docker#run with arguments" do
      expect(docker).to receive(:run).once.with("cli:net", "lftp", :a, :b, :c)
      subject.ftp(:a, :b, :c)
    end
  end

  describe "#metasploit" do
    it "calls docker#run with arguments" do
      expect(docker).to receive(:run).once.with("cli:metasploit", :a, :b, :c)
      subject.metasploit(:a, :b, :c)
    end
  end

  describe "#netcat" do
    it "calls docker#run with arguments" do
      expect(docker).to receive(:run).once.with("cli:net", "nc", :a, :b, :c)
      subject.netcat(:a, :b, :c)
    end
  end

  describe "#nc" do
    it "calls docker#run with arguments" do
      expect(docker).to receive(:run).once.with("cli:net", "nc", :a, :b, :c)
      subject.nc(:a, :b, :c)
    end
  end

  describe "#nmap" do
    it "calls docker#run with arguments" do
      expect(docker).to receive(:run).once.with("cli:net", "nmap", :a, :b, :c)
      subject.nmap(:a, :b, :c)
    end
  end

  describe "#ping" do
    it "calls docker#run with arguments" do
      expect(docker).to receive(:run).once.with("cli:net", "ping", :a, :b, :c)
      subject.ping(:a, :b, :c)
    end
  end

  describe "#rpcinfo" do
    it "calls docker#run with arguments" do
      expect(docker).to receive(:run).once.with("cli:net", "rpcinfo", :a, :b, :c)
      subject.rpcinfo(:a, :b, :c)
    end
  end

  describe "#showmount" do
    it "calls docker#run with arguments" do
      expect(docker).to receive(:run).once.with("cli:net", "showmount", :a, :b, :c)
      subject.showmount(:a, :b, :c)
    end
  end

  describe "#smbclient" do
    it "calls docker#run with arguments" do
      expect(docker).to receive(:run).once.with("cli:net", "smbclient", :a, :b, :c)
      subject.smbclient(:a, :b, :c)
    end
  end

  describe "#sqlmap" do
    it "calls docker#run with arguments" do
      expect(docker).to receive(:run).once.with("cli:sqlmap", :a, :b, :c)
      subject.sqlmap(:a, :b, :c)
    end
  end

  describe "#wpscan" do
    it "calls docker#run with arguments" do
      expect(docker).to receive(:run).once.with("cli:wpscan", :a, :b, :c)
      subject.wpscan(:a, :b, :c)
    end
  end

  describe "#wget" do
    it "calls docker#run with arguments" do
      expect(docker).to receive(:run).once.with("cli:net", "wget", :a, :b, :c)
      subject.wget(:a, :b, :c)
    end
  end
end
