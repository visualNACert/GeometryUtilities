//
//  MKCoordinateRegion+IsValid.swift
//  Pods
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 9/12/16.
//
//

import MapKit

extension MKCoordinateRegion {
    
    /// Whether this coordinate region is centered at 0 with a zero size or not.
    public var valid: Bool {
        get {
            return
                (-90.0...90.0).contains(self.center.latitude) &&
                (-180.0...180.0).contains(self.center.longitude) &&
                (-180.0...180.0).contains(self.span.latitudeDelta) &&
                (-360.0...360.0).contains(self.span.longitudeDelta)
        }
    }
    
}
