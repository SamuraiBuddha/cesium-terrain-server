# Quick Start Guide

## Running the Modernized Cesium Terrain Server on Windows

### 1. Create directories for your terrain data
```bash
# From the repository root
mkdir -p terrain-tiles/test
```

### 2. Build the Docker image
```bash
docker-compose build
# Or
./build-modern.sh
```

### 3. Run the server

#### Using docker-compose (Recommended)
```bash
docker-compose up -d
```

#### Using docker run on Windows
```bash
# From Git Bash (use forward slashes)
docker run -d -p 8080:8000 -v "$(pwd)/terrain-tiles:/data/tilesets/terrain" cesium-terrain-server:modern

# From PowerShell
docker run -d -p 8080:8000 -v "${PWD}/terrain-tiles:/data/tilesets/terrain" cesium-terrain-server:modern

# From CMD
docker run -d -p 8080:8000 -v "%cd%/terrain-tiles:/data/tilesets/terrain" cesium-terrain-server:modern
```

### 4. Test the server
Visit: http://localhost:8080/tilesets/

### 5. Add your terrain tiles
Place your terrain tile directories under `terrain-tiles/`. For example:
```
terrain-tiles/
├── my-terrain/
│   ├── 0/
│   │   └── 0/
│   │       └── 0.terrain
│   ├── 1/
│   │   └── 1/
│   │       └── 1.terrain
│   └── layer.json
```

The tiles will be available at: http://localhost:8080/tilesets/my-terrain/

## Troubleshooting Windows Paths

If you encounter path issues on Windows:

1. **Use absolute paths with forward slashes**:
   ```bash
   docker run -d -p 8080:8000 -v C:/Users/YourName/terrain:/data/tilesets/terrain cesium-terrain-server:modern
   ```

2. **Use `$(pwd)` in Git Bash**:
   ```bash
   docker run -d -p 8080:8000 -v "$(pwd)/terrain-tiles:/data/tilesets/terrain" cesium-terrain-server:modern
   ```

3. **Check Docker Desktop settings**:
   - Ensure the drive containing your terrain data is shared in Docker Desktop settings
   - Go to Docker Desktop → Settings → Resources → File Sharing

## Using with Caching

To enable caching with memcached and nginx:
```bash
docker-compose --profile with-cache up -d
```

This will start:
- Cesium Terrain Server on port 8000 (internal)
- Nginx reverse proxy on port 80
- Memcached for tile caching
