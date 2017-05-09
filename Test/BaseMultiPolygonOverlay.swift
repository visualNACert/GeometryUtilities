//
//  BaseMultiPolygonOverlay.swift
//  Example
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 9/5/17.
//
//

import XCTest
import GeometryUtilities
import Nimble
import MapKit

class BaseMultiPolygonOverlayTest: XCTestCase {
    
    func test__wkt_constructor() {
        
        let overlay = BaseMultiPolygonOverlay(
            wkt: "MULTIPOLYGON(((30 20, 45 40, 10 40, 30 20)), ((15 5, 40 10, 10 20, 5 10, 15 5)))"
        )
        
        expect(overlay).toNot(beNil())
        expect(overlay!.polygons).to(haveCount(2))
        expect(overlay!.simplifiedShapePointCount).to(equal(5))
        
    }
    
    func test__empty_string_wkt_constructor() {
        let overlay = BaseMultiPolygonOverlay(wkt: "")
        expect(overlay).to(beNil())
    }
    
    func test__empty_wkt_constructor() {
        let overlay = BaseMultiPolygonOverlay(wkt: "MULTIPOLYGON()")
        expect(overlay).to(beNil())
    }
    
    func test__invalid_wkt_constructor() {
        let overlay = BaseMultiPolygonOverlay(wkt: "INVALID")
        expect(overlay).to(beNil())
    }
    
    func test__polygons_constructor() {
        
        let polygonA = MKPolygon(
            coordinates: [
                CLLocationCoordinate2D(
                    latitude: 0,
                    longitude: 0
                ),
                CLLocationCoordinate2D(
                    latitude: 1,
                    longitude: 0
                ),
                CLLocationCoordinate2D(
                    latitude: 1,
                    longitude: 1
                ),
                CLLocationCoordinate2D(
                    latitude: 0,
                    longitude: 1
                )
            ]
        )
        
        let polygonB = MKPolygon(
            coordinates: [
                CLLocationCoordinate2D(
                    latitude: 6,
                    longitude: 8
                ),
                CLLocationCoordinate2D(
                    latitude: 9,
                    longitude: 10
                ),
                CLLocationCoordinate2D(
                    latitude: 11,
                    longitude: 7
                ),
                CLLocationCoordinate2D(
                    latitude: 6,
                    longitude: 8
                )
            ]
        )
        
        let polygons = [polygonA, polygonB]
        
        let overlay = BaseMultiPolygonOverlay(polygons: polygons)
        
        expect(overlay).toNot(beNil())
        expect(overlay!.polygons).to(haveCount(2))
        expect(overlay!.simplifiedShapePointCount).to(equal(5))
        
    }
    
    func test__empty_polygons_constructor() {
        let overlay = BaseMultiPolygonOverlay(polygons: [])
        expect(overlay).to(beNil())
    }
    
}
