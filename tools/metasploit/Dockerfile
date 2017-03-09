FROM alpine:3.5

COPY METASPLOIT_LICENSE /

RUN set -ex \
  && echo -e "install: --no-document\nupdate: --no-document" >> /etc/gemrc \
  && apk add --no-cache --virtual .run-deps \
    bash \
    ca-certificates \
    curl \
    git \
    libffi \
    libpcap \
    libxml2 \
    ncurses \
    nmap \
    openssl \
    postgresql-libs \
    readline \
    ruby \
    ruby-bigdecimal \
    ruby-bundler \
    ruby-irb \
    sqlite-libs \
    zlib \
  && apk add --no-cache --virtual .build-deps \
    build-base \
    libffi-dev \
    libpcap-dev \
    libxml2-dev \
    postgresql-dev \
    readline-dev \
    ruby-dev \
    sqlite-dev \
    zlib-dev \
  && git clone --depth 1 https://github.com/rapid7/metasploit-framework.git /usr/src/metasploit \
  && cd /usr/src/metasploit \
  && bundle install --without development coverage test \
  && apk del .build-deps

ENTRYPOINT ["/usr/src/metasploit/msfconsole", "--quiet", "--no-database"]
