GEM_VERSION = $(shell ruby -e "puts Penkit::VERSION" -r "./lib/penkit/version")

gem: penkit.gemspec
	gem build penkit.gemspec

install: gem
	gem install --user-install penkit-$(GEM_VERSION).gem
