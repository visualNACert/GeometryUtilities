//
//  GeometryUtilities+CLLocationCoordinate2D.swift
//  Visual
//
//  Created by Pablo Guardiola on 17/05/2017.
//  Copyright © 2017 VisualNACert. All rights reserved.
//

import Foundation
import MapKit

extension Array where Element == CLLocationCoordinate2D {
    
    /*
     Calculates the area (in Ha) from a coordinate array
     */
    
    public func area() -> Double {
        guard self.count > 2 else { return 0 }
        var area = 0.0
        
        for i in 0..<self.count {
            let p1 = self[i > 0 ? i - 1 : self.count - 1]
            let p2 = self[i]
            
            area += (p1.latitude * p2.longitude) - (p1.longitude * p2.latitude)
        }
        area = area / 2.0
        
        area = area * 111 //degree to Km
        area = abs(area) //Absolute value
        
        let areaHa = area * 10000 //Km2 to Ha
        
        return areaHa
    }
}
