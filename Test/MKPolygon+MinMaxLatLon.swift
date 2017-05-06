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

}
