FROM penkit/ruby:2.3.3

ENV \
  DOCKER_VERSION=1.13.1 \
  DOCKER_COMPOSE_VERSION=1.11.1

# install docker and docker-compose
RUN set -ex; \
  apk add --no-cache \
    ca-certificates \
    curl \
    openssl \
    ; \
  curl -fsSL "https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz; \
  tar -zxf docker.tgz; \
  mv docker/* /usr/local/bin/; \
  rmdir docker; \
  rm docker.tgz; \

  # install docker-compose
  curl -fsSL "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose; \
  chmod +x /usr/local/bin/docker-compose; \
  wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub; \
  wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk; \
  apk add --no-cache glibc-2.23-r3.apk && rm glibc-2.23-r3.apk; \
  ln -s /lib/libz.so.1 /usr/glibc-compat/lib/; \
  ln -s /lib/libc.musl-x86_64.so.1 /usr/glibc-compat/lib

# install penkit gem and entrypoint
COPY . /opt/ruby
RUN set -ex; \
  gem build penkit.gemspec; \
  gem install penkit-$(ruby -e "puts Penkit::VERSION" -r "./lib/penkit/version").gem; \
  mv penkit-entrypoint.sh /usr/local/sbin/; \
  mv scripts/* /usr/local/bin/; \
  rm -rf /opt/ruby/*

# set default command
ENV RUN_AS root
ENTRYPOINT ["/usr/local/sbin/penkit-entrypoint.sh"]
CMD ["help"]
