FROM golang:1.18 as builder
ARG XK6_VERSION="v0.6.1"

WORKDIR $GOPATH/src/github.com/H4nks/xk6-google-auth

RUN set -eux; \
  go install go.k6.io/xk6/cmd/xk6@$XK6_VERSION

COPY . .

RUN xk6 build \
  --output /go/bin/k6 \
  --with github.com/H4nks/xk6-google-auth=.

FROM alpine:3.15

RUN set -eux; \
  apk add --no-cache ca-certificates; \
  adduser -D -u 12345 -g 12345 k6

COPY --from=builder /go/bin/k6 /usr/bin/k6

USER 12345
WORKDIR /home/k6
ENTRYPOINT ["k6"]
