//
//  WKTParser.h
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun on 12/7/16.
//  Copyright © 2016 VisualNACert. All rights reserved.
//

#ifndef WKTParser_h
#define WKTParser_h

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

/**
 *  Data structure encapsulating minimum and maximum longitude and latitude.
 */
typedef struct {
  double minLon, minLat, maxLon, maxLat, centroidLon, centroidLat;
  int pointCount;
} MinMaxLonLat;

/**
 *  Returns minimum and maximum longitude and latitude found in given WKT
 *  multipolygon string.
 *
 *  @param wkt WKT multipolygon string to parse.
 *
 *  @return Minimum and maximum longitude and latitude found.
 */
MinMaxLonLat parseWKT(NSString *wkt);

/**
 *  Returns list of polygons in given WKT multipolygon string.
 *
 *  @param wkt WKT multipolygon string to parse.
 *
 *  @return List of polygons contained in given string.
 */
NSArray<MKPolygon *> *polygonsInWKT(NSString *wkt);

#endif /* WKTParser_h */
