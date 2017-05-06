//
//  Legacy.swift
//  Pods
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 5/5/17.
//
//

import MapKit

extension MinMaxLatLon {
    
    @available(*, deprecated: 1.4.0)
    public init(
        minLon: CLLocationDegrees,
        minLat: CLLocationDegrees,
        maxLon: CLLocationDegrees,
        maxLat: CLLocationDegrees,
        centroidLon: CLLocationDegrees,
        centroidLat: CLLocationDegrees,
        pointCount: Int32
    ) {
        self.init(
            minLat: minLat,
            minLon: minLon,
            maxLat: maxLat,
            maxLon: maxLon,
            centroidLat: centroidLat,
            centroidLon: centroidLon,
            pointCount: pointCount
        )
    }
    
}
