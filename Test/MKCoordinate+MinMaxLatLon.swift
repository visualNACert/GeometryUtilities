//
//  MKCoordinate+MinMaxLatLon.swift
//  Example
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 5/5/17.
//
//

import XCTest
import GeometryUtilities
import Nimble
import MapKit

class MKCoordinateMinMaxLatLonTest: XCTestCase {
    
    func test__MinMaxLatLon_MKCoodinateRegion_getter() {
        
        let mmll = MinMaxLatLon(
            minLat: 0.5,
            minLon: -2.1,
            maxLat: 1.7,
            maxLon: 3,
            centroidLat: 0.45,
            centroidLon: 1.1,
            pointCount: 4
        )
        
        let coordinateRegion = mmll.coordinateRegion
        
        expect(coordinateRegion.center.latitude)
            .to(beCloseTo(1.1, within: 0.1))
        expect(coordinateRegion.center.longitude)
            .to(beCloseTo(0.45, within: 0.1))
        expect(coordinateRegion.span.latitudeDelta)
            .to(beCloseTo(1.2, within: 0.1))
        expect(coordinateRegion.span.longitudeDelta)
            .to(beCloseTo(5.1, within: 0.1))
        
    }
    
    func test__MinMaxLatLon_MKCoodinateRegion_constructor() {
        
        let mmll = MinMaxLatLon(
            minLat: 0.5,
            minLon: -2.1,
            maxLat: 1.7,
            maxLon: 3,
            centroidLat: 0.45,
            centroidLon: 1.1,
            pointCount: 4
        )
        
        let coordinateRegion = MKCoordinateRegion(minMaxLatLon: mmll)
        
        expect(coordinateRegion.center.latitude)
            .to(beCloseTo(1.1, within: 0.1))
        expect(coordinateRegion.center.longitude)
            .to(beCloseTo(0.45, within: 0.1))
        expect(coordinateRegion.span.latitudeDelta)
            .to(beCloseTo(1.2, within: 0.1))
        expect(coordinateRegion.span.longitudeDelta)
            .to(beCloseTo(5.1, within: 0.1))
        
    }
        
    func test__MKCoodinateRegion_MinMaxLatLon_getter() {
        
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
        
        let mmll = coordinateRegion.minMaxLatLon
        
        expect(mmll.minLat).to(beCloseTo(0.5, within: 0.1))
        expect(mmll.minLon).to(beCloseTo(-2.1, within: 0.1))
        expect(mmll.maxLat).to(beCloseTo(1.7, within: 0.1))
        expect(mmll.maxLon).to(beCloseTo(3, within: 0.1))
        expect(mmll.centroidLat).to(beCloseTo(1.1, within: 0.1))
        expect(mmll.centroidLon).to(beCloseTo(0.45, within: 0.1))
        expect(mmll.pointCount).to(equal(4))
        
    }
    
    func test__MKCoodinateRegion_MinMaxLatLon_construcor() {
        
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
        
        let mmll = MinMaxLatLon(coordinateRegion: coordinateRegion)
        
        expect(mmll.minLat).to(beCloseTo(0.5, within: 0.1))
        expect(mmll.minLon).to(beCloseTo(-2.1, within: 0.1))
        expect(mmll.maxLat).to(beCloseTo(1.7, within: 0.1))
        expect(mmll.maxLon).to(beCloseTo(3, within: 0.1))
        expect(mmll.centroidLat).to(beCloseTo(1.1, within: 0.1))
        expect(mmll.centroidLon).to(beCloseTo(0.45, within: 0.1))
        expect(mmll.pointCount).to(equal(4))
        
    }
    
}
