//
//  MinMaxLatLon.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 9/5/17.
//

import Foundation

extension MinMaxLatLon {
    
    /// Centroid of this instance, computed from `self.centroidLat` and 
    /// `self.centroidLon`.
    public var centroid: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: self.centroidLat,
            longitude: self.centroidLon
        )
    }
    
}
