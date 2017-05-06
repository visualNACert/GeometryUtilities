//
//  MultiPolygon.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 24/9/16.
//
//

import Foundation
import StringUtilities

@available(*, deprecated: 1.4)
public struct MultiPolygon {
    
    /// Minimum point (lowest latitude and longitude) of this multi polygon.
    let min: (latitude: Double, longitude: Double)
    
    /// Maximum point (greatest latitude and longitude) of this multi polygon.
    let max: (latitude: Double, longitude: Double)
    
    /// Centroid of this multi polygon.
    let centroid: (latitude: Double, longitude: Double)
    
    /// Total amount of points defining this multi polygon.
    let pointCount: Int
    
    init(wktString wkt: String) {
        let minMaxLonLat = parseWKT(wkt)
        self.min = (
            latitude: minMaxLonLat.minLat,
            longitude: minMaxLonLat.minLon
        )
        self.max = (
            latitude: minMaxLonLat.maxLat, 
            longitude: minMaxLonLat.maxLon
        )
        self.centroid = (
            latitude: minMaxLonLat.centroidLat,
            longitude: minMaxLonLat.centroidLon
        )
        self.pointCount = Int(minMaxLonLat.pointCount)
    }
    
}
