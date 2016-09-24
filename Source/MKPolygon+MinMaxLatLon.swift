//
//  MKPolygon+MinMaxLatLon.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun on 20/7/16.
//  Copyright © 2016 VisualNACert. All rights reserved.
//

import MapKit

extension MKPolygon {

	/**
	 Creates a rectangular polygon covering given `MinMaxLonLat`.

	 - parameter mmll: `MinMaxLonLat` to be covered by polygon.

	 - returns: Rectangular polygon covering given `MinMaxLonLat`.
	 */
	public convenience init(minMaxLatLon mmll: MinMaxLonLat) {
        #if swift(>=3)
		let points = UnsafeMutablePointer<CLLocationCoordinate2D>.allocate(capacity: 5)
        #else
        let points = UnsafeMutablePointer<CLLocationCoordinate2D>.alloc(5)
        #endif
		points[0] = CLLocationCoordinate2D(latitude: mmll.minLat, longitude: mmll.minLon)
		points[1] = CLLocationCoordinate2D(latitude: mmll.maxLat, longitude: mmll.minLon)
		points[2] = CLLocationCoordinate2D(latitude: mmll.maxLat, longitude: mmll.maxLon)
		points[3] = CLLocationCoordinate2D(latitude: mmll.minLat, longitude: mmll.maxLon)
		points[4] = CLLocationCoordinate2D(latitude: mmll.minLat, longitude: mmll.minLon)
		self.init(coordinates: points, count: 5)
        #if swift(>=3)
		points.deinitialize(count: 5)
        #else
        points.destroy(5)
        #endif
	}

}
