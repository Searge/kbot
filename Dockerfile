FROM quay.io/projectquay/golang:1.20 as builder

LABEL maintainer "Serhii Boremchuk <elfimqsvg@mozmail.com>"

WORKDIR /go/src/app
COPY . .

RUN make install && make build

FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/kbot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs
ENTRYPOINT ["./kbot", "start"]
