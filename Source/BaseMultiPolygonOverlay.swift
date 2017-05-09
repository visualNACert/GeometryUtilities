//
//  BaseMultiPolygonOverlay.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 9/5/17.
//

import Foundation

/**
 A base implementation of `MultiPolygonOverlay` protocol. 
 */
@available(*, introduced: 2.1.0)
open class BaseMultiPolygonOverlay: NSObject, MultiPolygonOverlay {
    
    public let coordinate: CLLocationCoordinate2D
    
    public let boundingMapRect: MKMapRect
    
    public let complexShapePointCount: Int
    
    public var selected: Bool = false
    
    public let polygons: [MKPolygon]
    
    public let simplifiedPolygon: MKPolygon
    
    public var simplifiedShapePointCount: Int {
        return self.simplifiedPolygon.pointCount
    }
    
    public let uniqueIdentifier: String
    
    /**
     Creates a new instance with given WKT string with polygons to be displayed
     as a single one.
     
     - parameter uniqueIdentifier: Unique identifier of this overlay. When `nil`
     hash of given WKT string will be used as unique identifier.
     - parameter wkt: WKT string with serialized polygons to be displayed by 
     this overlay.
     
     - returns: Properly initialized instance of `nil` when given WKT string has
     no polygons or is invalid.
     */
    public convenience init?(uniqueIdentifier: String? = nil, wkt: String) {
        self.init(
            uniqueIdentifier: uniqueIdentifier,
            polygons: WKT.polygons(in: wkt)
        )
    }
    
    /**
     Creates a new instance with given collection of polygons to be displayed
     as a single one.
     
     - parameter uniqueIdentifier: Unique identifier of this overlay. When `nil`
     hash of WKT representation of given polygons will be used as unique 
     identifier.
     - parameter polygons: Polygons to be displayed by this overlay.
     
     - returns: Properly initialized instance of `nil` when given collection is
     empty.
     */
    public init?(uniqueIdentifier: String? = nil, polygons: [MKPolygon]) {
        
        guard let mmll = polygons.minMaxLatLon() else { return nil }
        
        self.coordinate = mmll.centroid
        
        self.polygons = polygons
        self.complexShapePointCount = polygons.reduce(0) { $0 + $1.pointCount }
        self.simplifiedPolygon = MKPolygon(minMaxLatLon: mmll)
        self.uniqueIdentifier = uniqueIdentifier ?? String(
            format: "%d",
            polygons.wktMultipolygonString().hashValue
        )
        
        let rects = self.polygons.map { $0.boundingMapRect }
        guard let firstRect = rects.first else { return nil }
        self.boundingMapRect = rects.dropFirst().reduce(firstRect, MKMapRectUnion)
        
    }
    
}
