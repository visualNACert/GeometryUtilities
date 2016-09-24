//
//  MKCoordinateRegion+MinMaxLatLon.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun on 20/7/16.
//  Copyright © 2016 VisualNACert. All rights reserved.
//

import Foundation

#if swift(>=3.0)
extension MinMaxLonLat {
    
    /**
     Creates a new `MinMaxLonLat` equivalent to given `MKCoordinateRegion`.
     
     - parameter coordinateRegion: A `MKCoordinateRegion`.
     
     - returns: Properly initialized instance.
     
     */
    @available(*, introduced: 0.0.8)
    public init(coordinateRegion: MKCoordinateRegion) {
        
        let center = coordinateRegion.center
        let span = coordinateRegion.span
        
        self.minLon = center.longitude - span.longitudeDelta / 2
        self.minLat = center.latitude - span.latitudeDelta / 2
        self.maxLon = center.longitude + span.longitudeDelta / 2
        self.maxLat = center.latitude + span.latitudeDelta / 2
        
        self.centroidLon = center.longitude
        self.centroidLat = center.latitude
        
        self.pointCount = 4
        
    }
    
}
    
extension MKCoordinateRegion {
    
    /// Minimum and maximum latitude and longitude of this region.
    @available(*, deprecated: 0.0.8, message: "Use MinMaxLonLat(coordinateRegion)")
    public var minMaxLatLon: MinMaxLonLat {
        get {
            return MinMaxLonLat(coordinateRegion:self)
        }
    }
    
}
#else
extension MKCoordinateRegion {

	/// Minimum and maximum latitude and longitude of this region.
	public var minMaxLatLon: MinMaxLonLat {
		get {
			return MinMaxLonLat(
				minLon: self.center.longitude - self.span.longitudeDelta / 2,
				minLat: self.center.latitude - self.span.latitudeDelta / 2,
				maxLon: self.center.longitude + self.span.longitudeDelta / 2,
				maxLat: self.center.latitude + self.span.latitudeDelta / 2,
				centroidLon: self.center.longitude,
				centroidLat: self.center.latitude,
				pointCount: 4
			)
		}
	}

}
#endif

    
#if swift(>=3.0)
extension MKCoordinateRegion {

    /**
     Creates a new `MKCoordinateRegion` equivalent to given `MinMaxLonLat`.
     
     - parameter minMaxLonLat: A `MinMaxLonLat`.
     
     - returns: Properly initialized instance.
     
     */
    @available(*, introduced: 0.0.8)
    public init(minMaxLonLat mmll: MinMaxLonLat) {
        
        let minCoordinate = CLLocationCoordinate2D(
            latitude: mmll.minLat,
            longitude: mmll.minLon
        )
        
        let maxCoordinate = CLLocationCoordinate2D(
            latitude: mmll.maxLat,
            longitude: mmll.maxLon
        )
        
        let center = (minCoordinate + maxCoordinate) / 2.0
        
        let delta = abs(maxCoordinate - minCoordinate)
        
        let span = MKCoordinateSpan(
            latitudeDelta: delta.latitude,
            longitudeDelta: delta.longitude
        )
        
        self.init(center: center, span: span)
        
    }
    
}
#endif

extension MinMaxLonLat {

    /// Coordinate region equivalent to rectangle defined by this minimum and 
    /// maximum longitude and latitude.
    #if swift(>=3.0)
    @available(*, deprecated: 0.0.8, message: "Use MKCoordinateRegion(minMaxLonLat:")
    public var coordinateRegion: MKCoordinateRegion {
        get {
            return MKCoordinateRegion(minMaxLonLat: self)
        }
    }
    #else
	public var coordinateRegion: MKCoordinateRegion {
		get {

			let minCoordinate = CLLocationCoordinate2DMake(
				self.maxLat,
				self.maxLon
			)

			let maxCoordinate = CLLocationCoordinate2DMake(
				self.minLat,
				self.minLon
			)

			let center = (minCoordinate + maxCoordinate) / 2.0

			let span = abs(maxCoordinate - minCoordinate)

			return MKCoordinateRegionMake(
				center,
				MKCoordinateSpan(
					latitudeDelta: span.latitude,
					longitudeDelta: span.longitude
				)
			)

		}
	}
    #endif

}
