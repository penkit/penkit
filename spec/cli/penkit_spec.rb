describe Penkit::CLI do
  it "extends thor" do
    expect(subject).to be_a(Thor)
  end

  it "includes helpers" do
    expect(subject).to be_a(Penkit::Helpers)
  end
end
