//
//  GeometryUtilities.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun on 8/7/16.
//  Copyright © 2016 VisualNACert. All rights reserved.
//

import Foundation
import StringUtilities

public struct GeometryUtilities {

    #if swift(>=3)
	/**
	 Returns minimum and maximum longitude and latitude of polygons in given
	 WKT geometry, its centroid and total point count.

	 - note: Uses Objective-C implementation for effiency's sake.

	 - parameter wkt: Geometry to analyze.

	 - returns: Minimum and maximum longitude and latitude.
	 */
	public static func minimumAndMaximumLongitudeAndLatitudeInWKTGeometry(
		_ wkt: String
	) -> (
		min: (lon: Double, lat: Double),
		max: (lon: Double, lat: Double),
		centroid: (lon: Double, lat: Double),
		pointCount: Int
	) {
		let minMaxLonLat = parseWKT(wkt)
		return (
			min: (lon: minMaxLonLat.minLon, lat: minMaxLonLat.minLat),
			max: (lon: minMaxLonLat.maxLon, lat: minMaxLonLat.maxLat),
			centroid: (
				lon: minMaxLonLat.centroidLon,
				lat: minMaxLonLat.centroidLat
			),
			pointCount: Int(minMaxLonLat.pointCount)
		)
	}
    #else
    /**
     Returns minimum and maximum longitude and latitude of polygons in given
     WKT geometry, its centroid and total point count.
     
     - note: Uses Objective-C implementation for effiency's sake.
     
     - parameter wkt: Geometry to analyze.
     
     - returns: Minimum and maximum longitude and latitude.
     */
    public static func minimumAndMaximumLongitudeAndLatitudeInWKTGeometry(
        wkt: String
    ) -> (
        min: (lon: Double, lat: Double),
        max: (lon: Double, lat: Double),
        centroid: (lon: Double, lat: Double),
        pointCount: Int
    ) {
        let minMaxLonLat = parseWKT(wkt)
        return (
            min: (lon: minMaxLonLat.minLon, lat: minMaxLonLat.minLat),
            max: (lon: minMaxLonLat.maxLon, lat: minMaxLonLat.maxLat),
            centroid: (
                lon: minMaxLonLat.centroidLon,
                lat: minMaxLonLat.centroidLat
            ),
            pointCount: Int(minMaxLonLat.pointCount)
        )
    }
    #endif

}
