//
//  CLLocationCoordinate2D+Area.swift
//  GeometryUtilities
//
//  Created by Pablo Guardiola on 17/05/2017.
//  Copyright © 2017 VisualNACert. All rights reserved.
//

import Foundation
import MapKit

extension BidirectionalCollection where Iterator.Element == CLLocationCoordinate2D, IndexDistance == Int {
    
    /*
     Calculates the area covered by coordinates in this collection.
     
     - returns: Area in hectometers (**Ha**).
     */
    public func area() -> Double {
        
        precondition(
            self.count > 2,
            "At least 3 coordinates are required to define an area"
        )
        
        guard let last = self.last else {
            fatalError("Collection's `last` must not be `nil`")
        }
        
        // TODO: Implement proper algorithm
        
        let area = self.reduce((area: 0.0, prev: last)) {
            
            let (area, p1) = $0
            let p2 = $1
            
            return (
                area: area + (p1.latitude * p2.longitude) - (p1.longitude * p2.latitude),
                prev: p2
            )
            
        }.area
        
        return abs(area / 2.0 * 1000000 * 0.952)
        
    }
    
}
