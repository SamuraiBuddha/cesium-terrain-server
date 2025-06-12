# Cesium.js Global Health & BIM Dashboard Demo

This demo shows how to create a Google Earth-style interface using Cesium.js with your local terrain server.

## Features

- 🌍 **3D Globe Visualization** - Google Earth-style interactive globe
- ⛰️ **Terrain Elevation** - Uses your local Cesium Terrain Server
- 🏥 **Health Monitoring** - Visualize global health data points
- 🏗️ **BIM Integration** - Add 3D building/infrastructure models
- 🌊 **Environmental Data** - Show hazards like flood zones, seismic activity
- 🎯 **Interactive Controls** - Click buttons to toggle different data layers

## Quick Start

1. **Ensure your terrain server is running**:
   ```bash
   docker-compose up -d
   ```

2. **Open the demo**:
   - Direct file: Open `demo/global-health-dashboard.html` in Chrome/Firefox
   - Or serve it: `python -m http.server 8000` then visit http://localhost:8000/demo/global-health-dashboard.html

3. **Get a Bing Maps API Key** (optional but recommended):
   - Get a free key from: https://www.bingmapsportal.com/
   - Replace `YOUR_BING_MAPS_KEY` in the HTML file
   - Without this, you'll see a Bing logo watermark on the imagery

## Demo Controls

- **Show Health Data** - Displays COVID/health monitoring points with risk levels
- **Add BIM Model** - Adds a sample 3D building (replace with real glTF models)
- **Show Environmental** - Shows flood zones and seismic activity
- **Clear All** - Removes all data overlays
- **Fly to NYC** - Animates camera to New York City

## Customization

### Add Your Own Data

1. **Health Data**: Modify the `healthLocations` array with your data points
2. **BIM Models**: Load actual glTF/3D models:
   ```javascript
   model: {
       uri: '/models/your-building.glb',
       scale: 1.0
   }
   ```
3. **Environmental**: Add polygons, circles, or other shapes for hazard zones

### Connect to Real APIs

Replace the static data with live feeds:
```javascript
// Example: Fetch real-time health data
fetch('https://your-api.com/health-data')
    .then(response => response.json())
    .then(data => {
        data.forEach(location => {
            viewer.entities.add({
                position: Cesium.Cartesian3.fromDegrees(location.lon, location.lat),
                // ... rest of entity properties
            });
        });
    });
```

### Use Different Terrain

Change the terrain provider URL:
```javascript
terrainProvider: new Cesium.CesiumTerrainProvider({
    url: 'http://localhost:8082/tilesets/your-terrain-name/'
})
```

## Next Steps

1. **Add Real Terrain Data** - Use Cesium Terrain Builder to create terrain from DEMs
2. **Integrate Real APIs** - Connect to health, weather, seismic data sources
3. **Load 3D Tiles** - Use Cesium 3D Tiles for city-scale BIM visualization
4. **Add Time Animation** - Use Cesium's timeline to show data changes over time
5. **WebSocket Updates** - Add real-time data updates for live monitoring

## Cesium Resources

- [Cesium Documentation](https://cesium.com/docs/)
- [Cesium Sandcastle](https://sandcastle.cesium.com/) - Interactive examples
- [Cesium Ion](https://cesium.com/ion/) - Host your terrain and 3D models
- [3D Tiles](https://github.com/CesiumGS/3d-tiles) - For large-scale 3D data

## Troubleshooting

- **Terrain not loading**: Ensure your terrain server is running on port 8082
- **CORS errors**: Serve the HTML file via a web server, not file://
- **No imagery**: Add a valid Bing Maps API key or use a different imagery provider
