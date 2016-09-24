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
        
        let coordinates = [
            (mmll.minLat, mmll.minLon),
            (mmll.maxLat, mmll.minLon),
            (mmll.maxLat, mmll.maxLon),
            (mmll.minLat, mmll.maxLon),
            (mmll.minLat, mmll.minLon)
        ].map { CLLocationCoordinate2D(latitude: $0.0, longitude: $0.1) }
        
        let points = UnsafeMutablePointer<CLLocationCoordinate2D>.allocate(
            capacity: coordinates.count
        )
        
        for (index, coordinate) in coordinates.enumerated() {
            points[index] = coordinate
        }
		
        self.init(coordinates: points, count: coordinates.count)
        
		points.deinitialize(count: coordinates.count)

	}

}
