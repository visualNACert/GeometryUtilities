[![Build Status](https://travis-ci.org/visualNACert/GeometryUtilities.svg?branch=master)](https://travis-ci.org/visualNACert/GeometryUtilities) [![codecov](https://codecov.io/gh/visualNACert/GeometryUtilities/branch/master/graph/badge.svg)](https://codecov.io/gh/visualNACert/GeometryUtilities) [![documentation](https://visualnacert.github.io/GeometryUtilities/badge.svg)](https://visualnacert.github.io/GeometryUtilities/) ![pod platforms](https://img.shields.io/cocoapods/p/GeometryUtilities.svg) ![pod version](https://img.shields.io/cocoapods/v/GeometryUtilities.svg) ![pod license](https://img.shields.io/cocoapods/l/GeometryUtilities.svg)

# Geometry Utilities

This is a small collection of geometry utilities to work with data in different projections, multiple polygons and polygon overlays:

- Parse `WKT` and extract multiple polygons (implemented in Objective-C for performance's sake).
- Convert multiple polygons into single `CGPathRef` to be drawable with `MapKit` as a single polygon.
- Convert from `Mercator` projection and `WGS84` coordinate system.

# API

```swift
// Extract polygons from a WKT string
let wkt = "MULTIPOLYGON(((0.0 0.0, 0.0 1.0, 1.0 1.0, 1.0 0.0)))"
let polygons = WKT.polygons(in: wkt)
let polygon = polygons.first
polygon?.coordinates() // (0, 0), (0, 1), (1, 1), (1, 0), (0, 0)

// Serialize polygons into a WKT string
let polygon = MKPolygon(
    coordinates: [
        CLLocationCoordinate2D(
            latitude: 0,
            longitude: 0
        ),
        CLLocationCoordinate2D(
            latitude: 1,
            longitude: 0
        ),
        CLLocationCoordinate2D(
            latitude: 1,
            longitude: 1
        ),
        CLLocationCoordinate2D(
            latitude: 0,
            longitude: 1
        )
    ]
)
polygon.wktString() // MULTIPOLYGON(((0.0 0.0, 0.0 1.0, 1.0 1.0, 1.0 0.0)))
```
