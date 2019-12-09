############################
# STEP 1 build executable binary
############################
FROM golang:alpine AS builder
# Git is required for fetching the dependencies.

RUN apk update && apk add --no-cache git ca-certificates && update-ca-certificates 

# Create appuser
RUN adduser -D -g '' appuser

# Fetch dependencies.# Using go get.
WORKDIR $GOPATH/src/mypackage/myapp/

# Using go mod.
# RUN go mod download
# RUN go mod verify
# Build the binary
COPY ./src . 
RUN go get -d -v

# Build the binary.
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /go/bin/demo

# STEP 2 build a small image
############################
# Copy our static executable.
FROM alpine:3.7

# Run the demo binary.
COPY --from=builder /go/bin/demo /go/bin/demo

ENTRYPOINT ["/go/bin/demo"]