# Imagery Providers Configuration

This file explains how to configure different map imagery providers for the Cesium demo.

## Quick Setup

Edit `global-health-dashboard.html` and replace the `imageryProvider` section with one of these options:

### 1. Bing Maps (Satellite + Labels)
Best quality satellite imagery with street labels.

```javascript
imageryProvider: new Cesium.BingMapsImageryProvider({
    url: 'https://dev.virtualearth.net',
    key: 'YOUR_BING_MAPS_KEY', // Get free key from https://www.bingmapsportal.com/
    mapStyle: Cesium.BingMapsStyle.AERIAL_WITH_LABELS
})
```

**Available Bing Styles:**
- `Cesium.BingMapsStyle.AERIAL` - Satellite only
- `Cesium.BingMapsStyle.AERIAL_WITH_LABELS` - Satellite + labels
- `Cesium.BingMapsStyle.ROAD` - Road map
- `Cesium.BingMapsStyle.CANVAS_DARK` - Dark theme
- `Cesium.BingMapsStyle.CANVAS_LIGHT` - Light theme
- `Cesium.BingMapsStyle.CANVAS_GRAY` - Gray theme

### 2. OpenStreetMap (Free, No Key)
Community-driven map data.

```javascript
imageryProvider: new Cesium.OpenStreetMapImageryProvider({
    url: 'https://a.tile.openstreetmap.org/'
})
```

### 3. ESRI World Imagery (Free, No Key)
High-quality satellite imagery.

```javascript
imageryProvider: new Cesium.ArcGisMapServerImageryProvider({
    url: 'https://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer'
})
```

### 4. ESRI World Street Map (Free, No Key)
Detailed street map.

```javascript
imageryProvider: new Cesium.ArcGisMapServerImageryProvider({
    url: 'https://services.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer'
})
```

### 5. Natural Earth II (Free, No Key)
Natural color, shaded relief imagery.

```javascript
imageryProvider: new Cesium.TileMapServiceImageryProvider({
    url: Cesium.buildModuleUrl('Assets/Textures/NaturalEarthII')
})
```

### 6. Mapbox Satellite (Requires Key)
High-quality satellite imagery with custom styling options.

```javascript
imageryProvider: new Cesium.MapboxImageryProvider({
    mapId: 'mapbox.satellite',
    accessToken: 'YOUR_MAPBOX_ACCESS_TOKEN' // Get from https://www.mapbox.com/
})
```

**Available Mapbox Styles:**
- `mapbox.satellite` - Satellite imagery
- `mapbox.streets` - Street map
- `mapbox.light` - Light theme
- `mapbox.dark` - Dark theme

### 7. Stamen Watercolor (Artistic)
Artistic watercolor-style map.

```javascript
imageryProvider: new Cesium.OpenStreetMapImageryProvider({
    url: 'https://stamen-tiles.a.ssl.fastly.net/watercolor/',
    fileExtension: 'jpg',
    credit: 'Map tiles by Stamen Design, under CC BY 3.0. Data by OpenStreetMap, under CC BY SA.'
})
```

## Multiple Imagery Layers

You can also add multiple imagery layers that users can toggle:

```javascript
// Add base layer
const viewer = new Cesium.Viewer('cesiumContainer', {
    baseLayerPicker: true, // Enable the layer picker widget
    imageryProviderViewModels: [
        new Cesium.ProviderViewModel({
            name: 'Bing Maps Aerial',
            iconUrl: Cesium.buildModuleUrl('Widgets/Images/ImageryProviders/bingAerial.png'),
            tooltip: 'Bing Maps aerial imagery',
            creationFunction: function () {
                return new Cesium.BingMapsImageryProvider({
                    url: 'https://dev.virtualearth.net',
                    key: 'YOUR_BING_MAPS_KEY',
                    mapStyle: Cesium.BingMapsStyle.AERIAL
                });
            }
        }),
        new Cesium.ProviderViewModel({
            name: 'OpenStreetMap',
            iconUrl: Cesium.buildModuleUrl('Widgets/Images/ImageryProviders/openStreetMap.png'),
            tooltip: 'OpenStreetMap',
            creationFunction: function () {
                return new Cesium.OpenStreetMapImageryProvider({
                    url: 'https://a.tile.openstreetmap.org/'
                });
            }
        }),
        new Cesium.ProviderViewModel({
            name: 'ESRI World Imagery',
            iconUrl: Cesium.buildModuleUrl('Widgets/Images/ImageryProviders/esriWorldImagery.png'),
            tooltip: 'ESRI World Imagery',
            creationFunction: function () {
                return new Cesium.ArcGisMapServerImageryProvider({
                    url: 'https://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer'
                });
            }
        })
    ]
});
```

## Getting API Keys

### Bing Maps (Recommended)
1. Go to https://www.bingmapsportal.com/
2. Sign in with Microsoft account
3. Click "My Account" → "My Keys"
4. Create new key:
   - Application name: Your app name
   - Key type: Basic (free)
   - Application type: Public website
5. Copy the key and replace `YOUR_BING_MAPS_KEY`

### Mapbox
1. Go to https://www.mapbox.com/
2. Sign up for free account
3. Go to Account → Access Tokens
4. Copy default public token or create new one
5. Replace `YOUR_MAPBOX_ACCESS_TOKEN`

### Cesium Ion (for terrain and 3D tiles)
1. Go to https://cesium.com/ion/
2. Sign up for free account
3. Go to Access Tokens
4. Copy default token
5. Add to your viewer: `Cesium.Ion.defaultAccessToken = 'YOUR_ION_TOKEN';`

## Performance Tips

- **Bing Maps**: Best overall quality and global coverage
- **ESRI**: Good alternative, no key required
- **OpenStreetMap**: Best for development/testing
- **Mapbox**: Most customization options

For production use, having a Bing Maps key is recommended as it provides the best satellite imagery quality and reliability.
