module DockerHelpers
  def stub_docker!
    let(:docker) { double(:docker) }
    before { allow(Penkit::Docker).to receive(:new).and_return(docker) }
  end

  def stub_docker_compose!
    let(:docker_compose) { double(:docker_compose) }
    before { allow(Penkit::DockerCompose).to receive(:new).and_return(docker_compose) }
  end
end

