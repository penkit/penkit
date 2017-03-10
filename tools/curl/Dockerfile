FROM alpine:3.5

COPY CURL_LICENSE /

RUN apk add --no-cache curl

ENTRYPOINT ["/usr/bin/curl"]
CMD ["--help"]
