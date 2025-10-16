# syntax=docker/dockerfile:1.6

# -------------------------------
# Stage 1: Builder
# -------------------------------
ARG GO_IMAGE_VERSION
FROM --platform=$BUILDPLATFORM golang:${GO_IMAGE_VERSION:-1.25.3-alpine3.22} AS builder

# Allow cross-compilation via buildx
ARG TARGETPLATFORM
ARG FABRIC_VERSION

# Install dependencies
RUN apk update && \
    apk upgrade && \
    apk add --no-cache git curl

# Set up environment
WORKDIR /app

# Install Fabric binary for the target platform
RUN goos=$(echo $TARGETPLATFORM | cut -d'/' -f1) && \
    goarch=$(echo $TARGETPLATFORM | cut -d'/' -f2) && \
    GOOS=$goos GOARCH=$goarch go install github.com/danielmiessler/fabric/cmd/fabric@${FABRIC_VERSION:-v1.4.319} && \
    if [ -f "/go/bin/${goos}_${goarch}/fabric" ]; then \
        mv "/go/bin/${goos}_${goarch}/fabric" /go/bin/fabric; \
    fi


# -------------------------------
# Stage 2: Runtime
# -------------------------------
FROM alpine:3.22

# Install runtime dependencies
RUN apk update && \
    apk upgrade && \
    apk add --no-cache bash npm busybox-suid curl git ca-certificates && \
    ln -sf /usr/sbin/crond /usr/bin/cron

# Copy Fabric binary from builder stage
COPY --from=builder /go/bin/fabric /usr/local/bin/fabric

# Copy bashrc and cron scripts
COPY .bashrc /root/.bashrc
COPY update-patterns.sh /usr/local/bin/update-patterns.sh
COPY mycron /etc/crontabs/root

# Permissions
RUN chmod +x /usr/local/bin/update-patterns.sh && \
    touch /var/log/cron.log

# Working directory
WORKDIR /go/bin

# Default command: start cron + fabric server
CMD /usr/sbin/crond -l 2 && \
    source /root/.bashrc && \
    fabric --serve
