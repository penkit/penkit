FROM penkit/ruby:2.3.3

ENV \
  DOCKER_VERSION=1.13.1

# install docker
RUN set -ex; \
  apk add --no-cache \
    ca-certificates \
    curl \
    openssl \
    ; \
  curl -fSL "https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz; \
  tar -zxf docker.tgz; \
  mv docker/* /usr/local/bin/; \
  rmdir docker; \
  rm docker.tgz

# install penkit gem and entrypoint
COPY . /opt/ruby
RUN set -ex; \
  gem build penkit.gemspec; \
  gem install penkit-$(ruby -e "puts Penkit::VERSION" -r "./lib/penkit/version").gem; \
  mv penkit-entrypoint.sh /usr/local/sbin/; \
  mv scripts/* /usr/local/bin/; \
  rm -rf /opt/ruby/*

# set default command
ENTRYPOINT ["/usr/local/sbin/penkit-entrypoint.sh"]
CMD ["help"]
