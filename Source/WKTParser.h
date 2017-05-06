//
//  WKTParser.h
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun on 12/7/16.
//  Copyright © 2016 VisualNACert. All rights reserved.
//

#ifndef WKTParser_h
#define WKTParser_h

#import <AvailabilityMacros.h>
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

/**
 *  Data structure encapsulating minimum and maximum longitude and latitude.
 */
typedef struct {
    /// Minimum latitude.
    double minLat;
    /// Minimum longitude.
    double minLon;
    /// Maximum latitude.
    double maxLat;
    /// Minimum longitude.
    double maxLon;
    /// Centroid's latitude.
    double centroidLat;
    /// Centroid's longitude.
    double centroidLon;
    /// Number of points in original polygon.
    int pointCount;
} MinMaxLatLon;

/**
 * Class wrapping WKT-parsing methods.
 */
@interface WKT : NSObject

/**
 *  Returns minimum and maximum longitude and latitude found in given WKT
 *  multipolygon string.
 *
 *  @param wkt WKT multipolygon string to parse.
 *
 *  @return Minimum and maximum longitude and latitude found.
 */
+ (MinMaxLatLon) minMaxLatLonOf: (NSString * _Nonnull) wkt NS_SWIFT_NAME(minMaxLatLon(of:));

/**
 *  Returns list of polygons in given WKT multipolygon string.
 *
 *  @param wkt WKT multipolygon string to parse.
 *
 *  @return List of polygons contained in given string.
 */
+ (NSArray<MKPolygon *> * _Nonnull) polygonsIn: (NSString * _Nonnull) wkt NS_SWIFT_NAME(polygons(in:));

@end

/**
 *  Legacy name of `MinMaxLatLon`.
 */
typedef MinMaxLatLon MinMaxLonLat DEPRECATED_MSG_ATTRIBUTE("Use MinMaxLatLon instead.");

/**
 *  Returns minimum and maximum longitude and latitude found in given WKT
 *  multipolygon string.
 *
 *  @param wkt WKT multipolygon string to parse.
 *
 *  @return Minimum and maximum longitude and latitude found.
 */
MinMaxLatLon parseWKT(NSString * _Nonnull wkt) DEPRECATED_MSG_ATTRIBUTE("Use [WKT minMaxLatLonOf:] instead.");

/**
 *  Returns list of polygons in given WKT multipolygon string.
 *
 *  @param wkt WKT multipolygon string to parse.
 *
 *  @return List of polygons contained in given string.
 */
NSArray<MKPolygon *> * _Nonnull polygonsInWKT(NSString * _Nonnull wkt) DEPRECATED_MSG_ATTRIBUTE("Use [WKT polygonsIn:] instead.");

#endif /* WKTParser_h */
