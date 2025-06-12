#!/bin/bash

# Build script for modernized Cesium Terrain Server

set -e

echo "Building modernized Cesium Terrain Server..."

# Detect if we're in the docker directory or repository root
if [ -f "Dockerfile" ] && [ -d "../cmd" ]; then
    echo "Building from docker directory..."
    docker build -t cesium-terrain-server:modern .
elif [ -f "docker/Dockerfile" ] && [ -d "cmd" ]; then
    echo "Building from repository root..."
    docker build -f docker/Dockerfile -t cesium-terrain-server:modern .
else
    echo "Error: Unable to determine build context. Please run from repository root or docker directory."
    exit 1
fi

echo ""
echo "Build complete! The image is tagged as: cesium-terrain-server:modern"
echo ""
echo "To run the server:"
echo "  docker run -d -p 8080:8000 -v /path/to/terrain:/data/tilesets/terrain cesium-terrain-server:modern"
echo ""
echo "Or use docker-compose:"
echo "  docker-compose up -d"
echo ""
echo "The server will be available at: http://localhost:8080/tilesets/"
