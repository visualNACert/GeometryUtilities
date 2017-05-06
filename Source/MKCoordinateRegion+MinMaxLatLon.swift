//
//  MKCoordinateRegion+MinMaxLatLon.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun on 20/7/16.
//  Copyright © 2016 VisualNACert. All rights reserved.
//

import Foundation

extension MinMaxLatLon {
    
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
    
    /// Coordinate region equivalent to this instance.
    @available(*, introduced: 1.4)
    public var coordinateRegion: MKCoordinateRegion {
        return MKCoordinateRegion(minMaxLatLon: self)
    }
    
}

extension MKCoordinateRegion {
    
    /**
     Creates a new `MKCoordinateRegion` equivalent to given `MinMaxLonLat`.
     
     - parameter minMaxLatLon: A `MinMaxLatLon`.
     
     - returns: Properly initialized instance.
     
     */
    @available(*, introduced: 1.4.0)
    public init(minMaxLatLon mmll: MinMaxLatLon) {
        
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
    
    /// Min max lon lat equivalent to this instance.
    @available(*, introduced: 1.4)
    public var minMaxLatLon: MinMaxLatLon {
        return MinMaxLatLon(coordinateRegion: self)
    }
    
}
