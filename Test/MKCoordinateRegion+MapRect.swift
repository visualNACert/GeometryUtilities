//
//  MKCoordinateRegion+MapRect.swift
//  Example
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 5/5/17.
//
//

import XCTest
import GeometryUtilities
import Nimble
import MapKit

class MKCoordinateRegionMapRectTest: XCTestCase {
    
    func test__mapRect() {
        
        let coordinateRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 1.1,
                longitude: 0.45
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 1.2,
                longitudeDelta: 5.1
            )
        )
        
        let mapRect = coordinateRegion.mapRect
        
        expect(mapRect.origin.x).to(beCloseTo(132651854.5067, within: 0.0001))
        expect(mapRect.origin.y).to(beCloseTo(133844896.2456, within: 0.0001))
        expect(mapRect.size.width).to(beCloseTo(3802835.6267, within: 0.0001))
        expect(mapRect.size.height).to(beCloseTo(-894966.1513, within: 0.0001))
        
    }
    
}
