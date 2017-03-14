FROM alpine:3.5

RUN apk add --no-cache \
  bash \
  curl \
  iputils \
  lftp \
  netcat-openbsd \
  nfs-utils \
  nmap \
  samba-client \
  rpcbind \
  wget

COPY licenses/* /

CMD ["bash"]
