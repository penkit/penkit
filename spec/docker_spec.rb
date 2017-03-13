describe Penkit::Docker do
  stub_system_calls!

  it "includes helpers" do
    expect(subject).to be_a(Penkit::Helpers)
  end
end
