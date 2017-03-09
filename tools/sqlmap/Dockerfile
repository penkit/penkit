FROM alpine:3.5

COPY SQLMAP_LICENSE /

RUN set -ex \
  && apk add --no-cache --virtual .run-deps \
    bash \
    ca-certificates \
    python \
  && apk add --no-cache --virtual .build-deps \
    git \
  && git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git /usr/src/sqlmap \
  && rm -rf /usr/src/sqlmap/.git \
  && apk del .build-deps

ENTRYPOINT ["/usr/bin/python", "/usr/src/sqlmap/sqlmap.py"]
CMD ["-h"]
