# --- Stage 1: Build the Cesium Terrain Server --- 
FROM golang:1.20-bullseye AS builder

# Install additional tools needed
RUN apt-get update && apt-get install -y --no-install-recommends \
    git mercurial unzip wget ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy source code into the build context
COPY . /app

# Disable Go modules to use GOPATH mode for this legacy project
ENV GO111MODULE=off

# Set up GOPATH workspace for the project
ENV GOPATH=/app/go
RUN mkdir -p "$GOPATH/src/github.com/geo-data" && \
    ln -s /app "$GOPATH/src/github.com/geo-data/cesium-terrain-server"

WORKDIR "$GOPATH/src/github.com/geo-data/cesium-terrain-server"

# Fetch Go dependencies and build the server
RUN go get -d -v ./... && \
    go build -v -o /app/bin/cesium-terrain-server ./cmd/cesium-terrain-server

# Download Cesium.js assets (optional - comment out if not needed)
# Note: Cesium 1.8 is from 2015. For newer versions, use GitHub releases
ARG CESIUM_VERSION=1.8
RUN mkdir -p /app/cesium && \
    if wget -q --spider "https://cesiumjs.org/releases/Cesium-${CESIUM_VERSION}.zip"; then \
        wget -q -O /tmp/cesium.zip "https://cesiumjs.org/releases/Cesium-${CESIUM_VERSION}.zip" && \
        unzip -q /tmp/cesium.zip -d /tmp && \
        mv /tmp/Apps /tmp/ThirdParty /tmp/Build /app/cesium/ 2>/dev/null || true && \
        rm -rf /tmp/cesium.zip /tmp/Cesium-* ; \
    else \
        echo "Warning: Cesium ${CESIUM_VERSION} not found at legacy URL. Skipping Cesium download." && \
        echo "You can mount Cesium files at runtime or update to use a newer version." && \
        echo "Creating empty cesium directory..." && \
        touch /app/cesium/.placeholder ; \
    fi

# --- Stage 2: Create the final runtime image ---
FROM ubuntu:22.04

# Set locale to UTF-8
ENV LANG=C.UTF-8

# Install ca-certificates for HTTPS support
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Create a user for security
RUN useradd -m -d /home/cesium cesium

# Create necessary directories
RUN mkdir -p /data/tilesets/terrain /data/cesium && chown -R cesium /data

# Copy the compiled server binary from builder
COPY --from=builder /app/bin/cesium-terrain-server /usr/local/bin/cesium-terrain-server

# Copy Cesium assets from builder (directory will exist even if empty)
COPY --from=builder /app/cesium /data/cesium

# Switch to non-root user
USER cesium

# Expose the server port
EXPOSE 8000

# Set the entrypoint to the server binary
ENTRYPOINT ["/usr/local/bin/cesium-terrain-server"]

# Default command arguments
CMD ["-dir", "/data/tilesets/terrain", "-port", "8000"]
