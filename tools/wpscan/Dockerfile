FROM alpine:3.5

COPY WPSCAN_LICENSE /

RUN set -ex \
  && echo -e "install: --no-document\nupdate: --no-document" >> /etc/gemrc \
  && apk add --no-cache --virtual .run-deps \
    bash \
    ca-certificates \
    libcurl \
    libffi \
    libgmpxx \
    libxml2 \
    openssl \
    procps \
    ruby \
    ruby-bigdecimal \
    ruby-bundler \
    ruby-irb \
    zlib \
  && apk add --no-cache --virtual .build-deps \
    build-base \
    git \
    gmp-dev \
    libffi-dev \
    libxml2-dev \
    openssl-dev \
    ruby-dev \
    zlib-dev \
  && git clone https://github.com/wpscanteam/wpscan.git /usr/src/wpscan \
  && cd /usr/src/wpscan \
  && rm -rf .git data.zip spec \
  && bundle install --without test \
  && apk del .build-deps \
  && /usr/src/wpscan/wpscan.rb --update --no-color

COPY wpscan-entrypoint.sh /usr/local/sbin/
ENTRYPOINT ["/usr/local/sbin/wpscan-entrypoint.sh"]
CMD ["--help"]
