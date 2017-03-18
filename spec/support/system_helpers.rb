module SystemHelpers
  def stub_system_calls!
    let(:lines) { [] }
    before do
      allow(subject).to receive(:exec).and_return(true)
      allow(subject).to receive(:system).and_return(true)
      allow(IO).to receive(:popen).and_return(double(:io, readlines: lines))
    end
  end
end

