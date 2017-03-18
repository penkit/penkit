class HelperClass
  include Penkit::Helpers
end

describe HelperClass do
  stub_docker!
  stub_docker_compose!

  describe "#docker" do
    it "returns and caches Compose instance" do
      expect(subject.instance_variable_get(:@docker)).to be_nil
      expect(subject.send(:docker)).to be(docker)
      expect(subject.instance_variable_get(:@docker)).to be(docker)
    end
  end

  describe "#docker_compose" do
    it "returns and caches DockerCompose instance" do
      expect(subject.instance_variable_get(:@docker)).to be_nil
      expect(subject.send(:docker)).to be(docker)
      expect(subject.instance_variable_get(:@docker)).to be(docker)
    end
  end

  describe "#has_config?" do
    context "when config exists" do
      it "returns true" do
        expect(File).to receive(:exist?).once.with(/\/wordpress\.yml$/).and_call_original
        expect(subject.send(:has_config?, "wordpress:4.7")).to eq(true)
      end
    end

    context "when config does not exists" do
      it "returns false" do
        expect(File).to receive(:exist?).once.with(/\/missing\.yml$/).and_call_original
        expect(subject.send(:has_config?, "missing:latest")).to eq(false)
      end
    end
  end

  describe "#image_name" do
    context "with name" do
      let(:image) { "rails" }

      it "returns image name" do
        expect(subject.send(:image_name, image)).to eq("rails")
      end
    end

    context "with name and tag" do
      let(:image) { "rails:3.2.9" }

      it "returns image name" do
        expect(subject.send(:image_name, image)).to eq("rails")
      end
    end

    context "with repository and tag" do
      let(:image) { "penkit/rails:3.2.9" }

      it "returns image name" do
        expect(subject.send(:image_name, image)).to be_nil
      end
    end

    context "with repository and name" do
      let(:image) { "penkit/rails" }

      it "returns image name" do
        expect(subject.send(:image_name, image)).to be_nil
      end
    end
  end

  describe "#image_url" do
    it "prepends repository name" do
      expect(subject.send(:image_url, "wordpress:4.7")).to eq("penkit/wordpress:4.7")
    end
  end

  describe "#unique_name" do
    let(:image) { "test:latest" }
    let(:container_names) { [] }
    before { allow(docker).to receive(:find_container_names).and_return(container_names) }

    context "with no containers" do
      it "returns test" do
        expect(subject.send(:unique_name, image)).to eq("test")
      end
    end

    context "with conflicting container" do
      let(:container_names) { %w(test) }

      it "returns test1" do
        expect(subject.send(:unique_name, image)).to eq("test1")
      end
    end

    context "with 5 conflicting containers" do
      let(:container_names) { %w(test) + (Array.new(4) {|i| "test#{i+1}" }) }

      it "returns test5" do
        expect(subject.send(:unique_name, image)).to eq("test5")
      end
    end

    context "with gap in conflicting containers" do
      let(:container_names) { %w(test test1 test3 test4) }

      it "returns test2" do
        expect(subject.send(:unique_name, image)).to eq("test2")
      end
    end

    context "with 98 conflicting containers" do
      let(:container_names) { %w(test) + (Array.new(97) {|i| "test#{i+1}" }) }

      it "returns test98" do
        expect(subject.send(:unique_name, image)).to eq("test98")
      end
    end

    context "with 99 conflicting containers" do
      let(:container_names) { %w(test) + (Array.new(98) {|i| "test#{i+1}" }) }

      it "returns test99" do
        expect(subject.send(:unique_name, image)).to eq("test99")
      end
    end

    context "with 100 conflicting containers" do
      let(:container_names) { %w(test) + (Array.new(99) {|i| "test#{i+1}" }) }

      it "returns test99" do
        expect(subject.send(:unique_name, image)).to eq("test99")
      end
    end
  end
end
