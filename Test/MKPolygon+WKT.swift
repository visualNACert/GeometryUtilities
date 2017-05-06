//
//  MKPolygon+WKT.swift
//  Example
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 5/5/17.
//
//

import XCTest
import GeometryUtilities
import Nimble
import MapKit

class MKPolygonWKTTest: XCTestCase {
    
    func test__wktMultipolygonString() {
        
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
        
        let smallDeltaPattern = "(0+[0-9]?)?"
        expect(polygonA.wktMultipolygonString()).to(match(
            String(
                format: "MULTIPOLYGON\\(\\(\\(0.%1$@ 0.%1$@, 0.%1$@ 1.%1$@, 1.%1$@ 1.%1$@, 1.%1$@ 0.%1$@\\)\\)\\)",
                smallDeltaPattern
            )
        ))
        
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
        
        expect(polygonB.wktMultipolygonString()).to(match(
            String(
                format: "MULTIPOLYGON\\(\\(\\(8.%1$@ 6.%1$@, 10.%1$@ 9.%1$@, 7.%1$@ 11.%1$@, 8.%1$@ 6.%1$@\\)\\)\\)",
                smallDeltaPattern
            )
        ))
        
    }
    
    func test__empty_collection_wktMultipolygonString() {
        
        let polygons: [MKPolygon] = []
        
        expect(polygons.wktMultipolygonString()).to(equal(""))
        
    }
    
    func test__collection_wktMultipolygonString() {
        
        let polygons = [
            MKPolygon(
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
            ),
            MKPolygon(
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
        ]
                
        let smallDeltaPattern = "(0+[0-9]?)?"
        expect(polygons.wktMultipolygonString()).to(match(
            String(
                format: "MULTIPOLYGON\\(\\(\\(0.%1$@ 0.%1$@, 0.%1$@ 1.%1$@, 1.%1$@ 1.%1$@, 1.%1$@ 0.%1$@\\)\\), \\(\\(8.%1$@ 6.%1$@, 10.%1$@ 9.%1$@, 7.%1$@ 11.%1$@, 8.%1$@ 6.%1$@\\)\\)\\)",
                smallDeltaPattern
            )
        ))
        
    }
    
}
