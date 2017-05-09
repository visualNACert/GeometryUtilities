//
//  MKCoordinateRegion+IsValid.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 9/12/16.
//

import MapKit

extension MKCoordinateRegion {
    
    /// Whether this coordinate region is valid or not.
    public var valid: Bool {
        return
            (-90.0...90.0).contains(self.center.latitude) &&
            (-180.0...180.0).contains(self.center.longitude) &&
            (0...180.0).contains(self.span.latitudeDelta) &&
            (0...360.0).contains(self.span.longitudeDelta)
    }
    
}
