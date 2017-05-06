//
//  CLLocationCoordinate2D+Zero.swift
//  Pods
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 25/11/16.
//
//

import MapKit

extension CLLocationCoordinate2D {
    
    /// Location coordinate for point at latitude and longitude 0.
    @available(*, introduced: 1.4.0)
    public static let zero = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    /// Whether this coordinate is `(0, 0)` or not.
    public var isZero: Bool {
        return self.latitude == 0 && self.longitude == 0
    }
    
    @available(*, introduced: 1.2.0, deprecated: 1.4.0, renamed:"CLLocationCoordinate2D.zero")
    /// Location coordinate for point at latitude and longitude 0.
    public static let Zero = CLLocationCoordinate2D.zero
    
}

/// Location coordinate for point at latitude and longitude 0.
@available(*, deprecated: 1.2.0, renamed: "CLLocationCoordinate2D.Zero")
public let CLLocationCoordinate2DZero = CLLocationCoordinate2D(
    latitude: 0,
    longitude: 0
)
