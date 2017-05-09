//
//  MKPolygon+MinMaxLatLon.swift
//  Example
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 5/5/17.
//
//

import XCTest
import GeometryUtilities
import Nimble
import MapKit

class MKPolygonMinMaxLatLonTest: XCTestCase {
    
    func test__constructor() {
        
        let mmll = MinMaxLatLon(
            minLat: 0.5,
            minLon: -2.1,
            maxLat: 1.7,
            maxLon: 3,
            centroidLat: 0.45,
            centroidLon: 1.1,
            pointCount: 4
        )
        
        let polygon = MKPolygon(minMaxLatLon: mmll)
        
        let coords = polygon.coordinates()
        
        let exists: (CLLocationCoordinate2D, [CLLocationCoordinate2D]) -> Bool = {
            
            (needle, haystack) -> Bool in
            
            return haystack.reduce(false) {
                
                return $0 || (
                    abs($1.latitude - needle.latitude) < 0.1 &&
                        abs($1.longitude - needle.longitude) < 0.1
                )
                
            }
            
        }
        
        let coordinates = [
            CLLocationCoordinate2D(
                latitude: 0.5,
                longitude: -2.1
            ),
            CLLocationCoordinate2D(
                latitude: 1.7,
                longitude: -2.1
            ),
            CLLocationCoordinate2D(
                latitude: 1.7,
                longitude: 3
            ),
            CLLocationCoordinate2D(
                latitude: 0.5,
                longitude: 3
            )
        ]
        
        for target in coordinates {
            expect(exists(target, coords)).to(beTrue())
        }
        
        for source in coords {
            expect(exists(source, coordinates)).to(beTrue())
        }
        
    }
    
    func test__collection_single_polygon() {
    
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
        
        let collection = [polygonA]
        
        let mmll = collection.minMaxLatLon()
        
        expect(mmll).toNot(beNil())
        
        expect(mmll!.minLat).to(beCloseTo(0, within: 0.1))
        expect(mmll!.minLon).to(beCloseTo(0, within: 0.1))
        expect(mmll!.maxLat).to(beCloseTo(1, within: 0.1))
        expect(mmll!.maxLon).to(beCloseTo(1, within: 0.1))
        expect(mmll!.centroidLat).to(beCloseTo(0.5, within: 0.1))
        expect(mmll!.centroidLon).to(beCloseTo(0.5, within: 0.1))
        expect(mmll!.pointCount).to(equal(4))
        
    }
    
    func test__collection_single_multiple_polygon_() {
        
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
        
        let collection = [polygonA, polygonB]
        
        let mmll = collection.minMaxLatLon()
        
        expect(mmll).toNot(beNil())
        
        expect(mmll!.minLat).to(beCloseTo(0, within: 0.1))
        expect(mmll!.minLon).to(beCloseTo(0, within: 0.1))
        expect(mmll!.maxLat).to(beCloseTo(11, within: 0.1))
        expect(mmll!.maxLon).to(beCloseTo(10, within: 0.1))
        expect(mmll!.centroidLat).to(beCloseTo(4.25, within: 0.1))
        expect(mmll!.centroidLon).to(beCloseTo(4.375, within: 0.1))
        expect(mmll!.pointCount).to(equal(8))
        
    }
    
    func test__collection_empty() {
        
        let collection = [MKPolygon]()
        
        expect(collection.minMaxLatLon()).to(beNil())
        
    }

}
