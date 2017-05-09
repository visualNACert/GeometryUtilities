//
//  WKTParser.m
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun on 12/7/16.
//

#import "WKTParser.h"

#ifndef min
#define min(a, b) (((a) < (b)) ? (a) : (b))
#endif

#ifndef max
#define max(a, b) (((a) > (b)) ? (a) : (b))
#endif

/**
 *  Updates given MinMaxLatLon so it keeps proper minimum and maximum
 *  longitude knowing that given longitude is a possible minimum and maximum.
 *
 *  @param current           MinMaxLatLon to update.
 *  @param proposedLongitude Longitude to be considered.
 */
NS_INLINE void keepLongitude(MinMaxLatLon *current, double proposedLongitude);

/**
 *  Updates given MinMaxLonLat so it keeps proper minimum and maximum
 *  latitude knowing that given latitude is a possible minimum and maximum.
 *
 *  @param current          MinMaxLatLon to update.
 *  @param proposedLatitude Latitude to be considered.
 */
NS_INLINE void keepLatitude(MinMaxLatLon *current, double proposedLatitude);

/**
 *  Returns a printable description of given `MinMaxLatLon`.
 *
 *  @param mmll `MinMaxLatLon` whose printable description will be returned.
 *
 *  @return Printable description of given `MinMaxLatLon`.
 */
/*
NS_INLINE NSString *NSStringFromMinMaxLonLat(MinMaxLatLon mmll);
 */

/**
 *  Returns a new MinMaxLatLon initialized with minimum and maximum possible
 *  values.
 *
 *  @return MinMaxLatLon initialized with maximum minimums and minimum maximums.
 */
NS_INLINE MinMaxLatLon base(void);

#pragma mark - Implementation

NS_INLINE void keepLongitude(MinMaxLatLon *current, double proposedLongitude) {
  current->minLon = min(current->minLon, proposedLongitude);
  current->maxLon = max(current->maxLon, proposedLongitude);
}

NS_INLINE void keepLatitude(MinMaxLatLon *current, double proposedLatitude) {
  current->minLat = min(current->minLat, proposedLatitude);
  current->maxLat = max(current->maxLat, proposedLatitude);
}

NS_INLINE MinMaxLatLon base() {
  MinMaxLatLon base;
  base.minLon = 180.0;
  base.maxLon = -180.0;
  base.minLat = 180.0;
  base.maxLat = -180.0;
  base.pointCount = 0;
  return base;
}

@implementation WKT

+ (MinMaxLatLon) minMaxLatLonOf: (NSString * _Nonnull) wkt {
    
    MinMaxLatLon mmll = base();
    
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression
                 regularExpressionWithPattern:@"(-?\\d+(?:\\.\\d+)?)"
                 options:NSRegularExpressionCaseInsensitive
                 error:nil];
    });
    
    NSArray<NSTextCheckingResult *> *matches =
    [regex matchesInString:wkt
                   options:NSMatchingWithoutAnchoringBounds
                     range:NSMakeRange(0, wkt.length)];
    
    mmll.centroidLon = 0;
    mmll.centroidLat = 0;
    
    bool isLongitude = true;
    for (NSTextCheckingResult *res in matches) {
        double number = [wkt substringWithRange:res.range].doubleValue;
        if (isLongitude) {
            mmll.centroidLon += number;
            keepLongitude(&mmll, number);
        } else {
            mmll.centroidLat += number;
            keepLatitude(&mmll, number);
        }
        mmll.pointCount++;
        isLongitude = !isLongitude;
    }
    
    mmll.pointCount /= 2;
    
    if (mmll.pointCount > 0) {
        mmll.centroidLon /= mmll.pointCount;
        mmll.centroidLat /= mmll.pointCount;
    }
    
    return mmll;
    
}


+ (NSArray<MKPolygon *> * _Nonnull) polygonsIn: (NSString * _Nonnull) wkt {
    
    static NSRegularExpression *polygonsRegex, *coordinatesRegex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        polygonsRegex = [NSRegularExpression
                         regularExpressionWithPattern:
                         @"\\(([^\\)\\(]*)\\)" //@"(-?\\d+(?:\\.\\d+)?)"
                         options:NSRegularExpressionCaseInsensitive
                         error:nil];
        coordinatesRegex = [NSRegularExpression
                            regularExpressionWithPattern:@"(-?\\d+(?:\\.\\d+)?)"
                            options:NSRegularExpressionCaseInsensitive
                            error:nil];
    });
    
    NSArray<NSTextCheckingResult *> *polygonsMatches =
    [polygonsRegex matchesInString:wkt
                           options:NSMatchingWithoutAnchoringBounds
                             range:NSMakeRange(0, wkt.length)];
    
    NSMutableArray<MKPolygon *> *polygons =
    [NSMutableArray arrayWithCapacity:polygonsMatches.count];
    
    for (NSTextCheckingResult *polygonRes in polygonsMatches) {
        
        NSString *polygonString = [wkt substringWithRange:polygonRes.range];
        
        NSArray<NSTextCheckingResult *> *coordinatesMatches =
        [coordinatesRegex matchesInString:polygonString
                                  options:NSMatchingWithoutAnchoringBounds
                                    range:NSMakeRange(0, polygonString.length)];
        
        CLLocationCoordinate2D *polygonCoordinates =
        malloc(coordinatesMatches.count / 2 * sizeof(CLLocationCoordinate2D));
        
        NSUInteger coordinatesAdded = 0;
        bool isLongitude = true;
        double lastLongitude = 0;
        for (NSTextCheckingResult *coordinateRes in coordinatesMatches) {
            double number =
            [polygonString substringWithRange:coordinateRes.range].doubleValue;
            if (isLongitude) {
                lastLongitude = number;
            } else {
                polygonCoordinates[coordinatesAdded] =
                CLLocationCoordinate2DMake(number, lastLongitude);
                coordinatesAdded++;
            }
            isLongitude = !isLongitude;
        }
        
        MKPolygon *polygon = [MKPolygon polygonWithCoordinates:polygonCoordinates
                                                         count:coordinatesAdded];
        
        if (coordinatesAdded > 0) {
            [polygons addObject:polygon];
        }
        
        free(polygonCoordinates);
    }
    
    return polygons;
    
}

@end
