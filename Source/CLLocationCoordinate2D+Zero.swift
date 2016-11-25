//
//  CLLocationCoordinate2D+Zero.swift
//  Pods
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 25/11/16.
//
//

import MapKit

extension CLLocationCoordinate2D {

    /// Whether this coordinate is `(0, 0)` or not.
    public var isZero: Bool {
        get {
            return self.latitude == 0 && self.longitude == 0
        }
    }
    
}
