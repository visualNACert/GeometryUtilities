//
//  MKCoordinateRegion+Zero.swift
//  Pods
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 24/11/16.
//
//

import MapKit

extension MKCoordinateRegion {
    
    /// Returns a `(0, 0, 0, 0)` coordinate region.
    @available(*, introduced: 1.4.0)
    public static let zero: MKCoordinateRegion = MKCoordinateRegionMake(
        CLLocationCoordinate2D.zero,
        MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 0)
    )
    
    /// Whether this coordinate region is centered at 0 with a zero size or not.
    public var isZero: Bool {
        return (
            self.center.latitude == 0 &&
            self.center.longitude == 0 &&
            self.span.latitudeDelta == 0 &&
            self.span.longitudeDelta == 0
        )
    }
    
}
