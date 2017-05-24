//
//  CLLocationCoordinate2D+Area.swift
//  GeometryUtilities
//
//  Created by Pablo Guardiola on 17/05/2017.
//  Copyright © 2017 VisualNACert. All rights reserved.
//

import Foundation
import MapKit

extension BidirectionalCollection where Iterator.Element == CLLocationCoordinate2D, SubSequence.Iterator.Element == CLLocationCoordinate2D, IndexDistance == Int {
    
    /*
     Calculates the area covered by coordinates in this collection.
     
     - returns: Area in square meters (**m^2**).
     */
    public func area() -> Double {
        
        guard self.last == self.first else {
            
            guard let first = self.first else {
                fatalError("At least 3 coordinates are required to define an area")
            }
            
            return (Array(self) + [first]).area()
            
        }
        
        precondition(
            self.count > 2,
            "At least 3 coordinates are required to define an area"
        )
        
        guard let first = self.first, let second = self.dropFirst().first else {
            fatalError("At least 3 coordinates are required to define an area")
        }
        
        typealias CoordinatePair = (
            source: CLLocationCoordinate2D,
            target: CLLocationCoordinate2D
        )
        
        let firstPair: CoordinatePair = (
            source: first,
            target: second
        )
        
        let pairs: [CoordinatePair] = self.dropFirst(2).reduce([firstPair]) {
            
            let prev = $0.last ?? firstPair
            
            return $0 + [(
                source: prev.target,
                target: $1
            )]
            
        }
        
        // TODO: Implement proper algorithm

        let area = pairs.reduce(0.0) { area, pair in
            
            let (source, target) = pair
            
            return area + (
                source.longitude * target.latitude
            ) - (
                source.latitude * target.longitude
            )
            
        }
        
        return abs(area / 2.0) * 10000000000
        
    }
    
}
