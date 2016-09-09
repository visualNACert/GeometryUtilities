//
//  GeometryUtilities.swift
//  Visual
//
//  Created by Lluís Ulzurrun on 8/7/16.
//  Copyright © 2016 VisualNACert. All rights reserved.
//

import Foundation
import StringUtilities

public struct GeometryUtilities {

	/**
	 Returns minimum and maximum longitude and latitude of polygons in given
	 WKT geometry.

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

	/**
	 Returns minimum and maximum longitude and latitude of polygons in given
	 WKT geometry.

	 - note: Uses split in its implementation.

	 - parameter wkt: Geometry to analyze.

	 - throws: Error when given geometry is not a valid WKT geometry.

	 - returns: Minimum and maximum longitude and latitude.
	 */
	private static func minimumAndMaximumLongitudeAndLatitudeInWKTGeometry_splitted_implementation(wkt: String) throws ->
	(min: (lon: Double, lat: Double), max: (lon: Double, lat: Double)) {

		var baseMinMax:
			(min: (lon: Double, lat: Double), max: (lon: Double, lat: Double)) =
			(min: (lon: 180, lat: 180), max: (lon: -180, lat: -180))

		let polygons = wkt.stringByRemoving(["MULTIPOLYGON(((", ")))"]).componentsSeparatedByString(")),((")

		for polygon in polygons {

			let points = polygon.componentsSeparatedByString(",")

			for point in points {

				let pair = point.componentsSeparatedByString(" ")

				guard let longitude = Double(pair[0]), latitude = Double(pair[1]) else { continue }

				let mins = baseMinMax.min
				let maxs = baseMinMax.max

				baseMinMax = (
					min: (min(mins.lon, longitude), min(mins.lat, latitude)),
					max: (max(maxs.lon, longitude), max(maxs.lat, latitude))
				)

			}

		}

		if baseMinMax.min.lon == 180 {
			throw NSError(
				domain: "GeometryUtilities.minimumAndMaximumLongitudeAndLatitudeInWKTGeometry_splitted_implementation",
				code: -1,
				userInfo: ["wkt": wkt]
			)
		}

		return baseMinMax

	}

}