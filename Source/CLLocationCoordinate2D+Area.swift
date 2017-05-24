//
//  CLLocationCoordinate2D+Area.swift
//  GeometryUtilities
//
//  Created by Pablo Guardiola on 17/05/2017.
//  Copyright © 2017 VisualNACert. All rights reserved.
//

import Foundation
import MapKit

extension BidirectionalCollection where Iterator.Element == CLLocationCoordinate2D, SubSequence.Iterator.Element == CLLocationCoordinate2D {
    
    /*
     Calculates the area covered by coordinates in this collection.
     
     [Reference](https://trs-new.jpl.nasa.gov/handle/2014/40409)
     Robert. G. Chamberlain and William H. Duquette, "Some Algorithms for
     Polygons on a Sphere", JPL Publication 07-03, Jet Propulsion
     Laboratory, Pasadena, CA, June 2007

     Ported from [OpenLayers](https://github.com/openlayers/openlayers/blob/master/src/ol/sphere.js)
     
     - returns: Area in square meters (**m^2**).
     */
    public func area() -> Double {
        
        precondition(
            !self.dropFirst(2).isEmpty,
            "At least 3 coordinates are required to define an area"
        )
        
        let radians: (Double) -> Double = { $0 * .pi / 180.0 }
        let earthRadiusInMeters: Double = 6378137
        
        guard let first = self.first else {
            fatalError("First coordinate must not be `nil`")
        }
        
        let closedPolygon = first == self.last
        
        let ring = closedPolygon ? Array(self) : Array(self) + [self.last!]
        
        guard let last = ring.last else {
            fatalError("Last coordinate must not be `nil`")
        }
        
        typealias CoordinatePair = (
            source: CLLocationCoordinate2D,
            target: CLLocationCoordinate2D
        )
        
        let pairs: [CoordinatePair] = ring.reduce([]) { otherPairs, target in
            
            let source = otherPairs.last?.target ?? last
            
            return otherPairs + [(
                source: source,
                target: target
            )]
            
        }
        
        let area = pairs.reduce(0.0) { area, pair in
            
            let (source, target) = pair
            
            let longitudeDelta = radians(target.longitude - source.longitude)
            let sourceLatitudeSin = sin(radians(source.latitude))
            let targetLatitudeSin = sin(radians(target.latitude))
            let a = 2 + sourceLatitudeSin + targetLatitudeSin
            
            return area + longitudeDelta * a
            
        }
        
        return abs(area * earthRadiusInMeters * earthRadiusInMeters / 2.0)
        
    }
    
}
