//
//  CLLocationCoordinate2D+Mercator.swift
//  Pods
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 1/11/16.
//
//

import MapKit

extension CLLocationCoordinate2D {
    
    /// Mercator X component of this coordinate.
    var mercatorX: Double {
        get {
            return self.longitude * 20037508.34 / 180;
        }
    }
    
    /// Mercator Y component of this coordinate.
    var mercatorY: Double {
        get {
            return log(
                tan((90 + latitude) * M_PI / 360)
            ) / (M_PI / 180) * 20037508.34 / 180;
        }
    }
    
}
