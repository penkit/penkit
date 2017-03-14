describe Penkit::CLI do
  it "extends thor" do
    expect(subject).to be_a(Thor)
  end

  it "includes helpers" do
    expect(subject).to be_a(Penkit::Helpers)
  end

  describe "#version" do
    it "prints current version" do
      expect { subject.version }.to output("#{Penkit::VERSION}\n").to_stdout
    end
  end
end
