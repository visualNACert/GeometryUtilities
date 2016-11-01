//
//  MKPolygon+WKT.swift
//  Pods
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 1/11/16.
//
//

import MapKit

extension MKPolygon {
    
    /// Returns WKT multipolygon for this polygon.
    public func wktMultipolygonString() -> String {
        return "MULTIPOLYGON(\(self.wktPolygonString()))"
    }
    
    /// Returns WKT polygon without type declaration, useful to combine this to
    /// create complex multipolygons.
    internal func wktPolygonString() -> String {
        
        let coordinates = self.coordinates().map {
            "\($0.longitude) \($0.latitude)"
        }
        
        let coordinatesString = coordinates.joinWithSeparator(", ")
        
        return "((\(coordinatesString)))"
        
    }
    
}

extension CollectionType where Generator.Element == MKPolygon {
    
    /// Returns multipolygon for this collection of polygons.
    public func wktMultipolygonString() -> String {
        let polygons = self.map { $0.wktPolygonString() }
        let polygonsString = polygons.joinWithSeparator(", ")
        return "MULTIPOLYGON(\(polygonsString))"
    }
    
}
