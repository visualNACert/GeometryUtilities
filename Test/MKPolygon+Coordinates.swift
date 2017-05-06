//
//  MKPolygon+Coordinates.swift
//  Example
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 5/5/17.
//
//

import XCTest
import GeometryUtilities
import Nimble
import MapKit

class MKPolygonCoordinatesTest: XCTestCase {
    
    func test__coordinates() {
        
        var coordinates = [
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
        
        let polygon = MKPolygon(
            coordinates: &coordinates,
            count: coordinates.count
        )
        
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
        
        for target in coordinates {
            expect(exists(target, coords)).to(beTrue())
        }
        
        for source in coords {
            expect(exists(source, coordinates)).to(beTrue())
        }
        
    }
    
    func test__coordinates_constructor() {
        
        let coordinates = [
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
        
        let polygon = MKPolygon(coordinates: coordinates)
        
        var coords = [CLLocationCoordinate2D](
            repeating: .zero,
            count: coordinates.count
        )
        polygon.getCoordinates(
            &coords,
            range: NSRange(location: 0, length: coordinates.count)
        )
        
        let exists: (CLLocationCoordinate2D, [CLLocationCoordinate2D]) -> Bool = {
            
            (needle, haystack) -> Bool in
            
            return haystack.reduce(false) {
                
                return $0 || (
                    abs($1.latitude - needle.latitude) < 0.1 &&
                    abs($1.longitude - needle.longitude) < 0.1
                )
                
            }
            
        }
        
        for target in coordinates {
            expect(exists(target, coords)).to(beTrue())
        }
        
        for source in coords {
            expect(exists(source, coordinates)).to(beTrue())
        }
        
    }
    
    func test__containsPointAt() {
        
        var coordinates = [
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
        
        let polygon = MKPolygon(
            coordinates: &coordinates,
            count: coordinates.count
        )
        
        let expectedCoordinates = coordinates + [
            CLLocationCoordinate2D(
                latitude: 0.5,
                longitude: 0.5
            ),
            CLLocationCoordinate2D(
                latitude: 0.75,
                longitude: 0.5
            ),
            CLLocationCoordinate2D(
                latitude: 0.9,
                longitude: 0.1
            ),
            CLLocationCoordinate2D(
                latitude: 0.1,
                longitude: 0.3
            )
        ]
        
        let unexpectedCoordinates = [
            CLLocationCoordinate2D(
                latitude: -0.5,
                longitude: 0.5
            ),
            CLLocationCoordinate2D(
                latitude: 1.5,
                longitude: 0.5
            ),
            CLLocationCoordinate2D(
                latitude: 1.0,
                longitude: 1.5
            ),
            CLLocationCoordinate2D(
                latitude: 0.5,
                longitude: -0.5
            )
        ]
        
        for coordinate in expectedCoordinates {
            expect(polygon.contains(pointAt: coordinate)).to(beTrue())
        }
        
        for coordinate in unexpectedCoordinates {
            expect(polygon.contains(pointAt: coordinate)).to(beFalse())
        }
        
    }
    
}
