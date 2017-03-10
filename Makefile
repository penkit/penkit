GEM_VERSION = $(shell ruby -e "puts Penkit::VERSION" -r "./lib/penkit/version")
TOOL_LIST := curl metasploit sqlmap wpscan

gem: penkit.gemspec
	gem build penkit.gemspec

install: gem
	gem install --user-install penkit-$(GEM_VERSION).gem

docker-build-tools: $(addprefix docker-build-,$(TOOL_LIST)) ;
docker-build-%: tools/%/Dockerfile
	docker build -t penkit/cli:$* tools/$*

docker-push-tools: $(addprefix docker-push-,$(TOOL_LIST)) ;
docker-push-%: tools/%/Dockerfile
	docker push penkit/cli:$*
