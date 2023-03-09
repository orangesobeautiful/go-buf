FROM docker.io/library/golang:1.20.2-alpine

CMD ["/bin/sh"]

# install protoc
RUN apk add --no-cache protobuf-dev

# install protoc go
RUN go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@latest \
    && go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@latest \
    && go install google.golang.org/protobuf/cmd/protoc-gen-go@latest \
    && go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest \
    && go clean -cache && go clean -modcache

# install buf
ENV BUF_VERSION="1.15.1"

RUN wget -qO- \
    "https://github.com/bufbuild/buf/releases/download/v${BUF_VERSION}/buf-$(uname -s)-$(uname -m).tar.gz" | \
    tar -xvzf - -C "/usr/local" --strip-components 1