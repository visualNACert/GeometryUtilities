//
//  MKCoordinateRegion+Zero.swift
//  Example
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 5/5/17.
//
//

import XCTest
import GeometryUtilities
import Nimble
import MapKit

class MKCoordinateRegionZeroTest: XCTestCase {
    
    func test__zero_is_returned() {
        
        let zero = MKCoordinateRegion.zero
        
        expect(zero.center.latitude).to(equal(0))
        expect(zero.center.longitude).to(equal(0))
        expect(zero.span.latitudeDelta).to(equal(0))
        expect(zero.span.longitudeDelta).to(equal(0))
        
    }
    
    func test__zero_is_detected() {
        
        let zero = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 0,
                longitude: 0
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0,
                longitudeDelta: 0
            )
        )
        
        expect(zero.isZero).to(beTrue())
        
    }
    
    func test__non_zero_is_detected() {
        
        expect(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: 1,
                    longitude: 0
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: 0,
                    longitudeDelta: 0
                )
            )
            .isZero
        ).to(beFalse())
        
        expect(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: 0,
                    longitude: 1
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: 0,
                    longitudeDelta: 0
                )
            )
            .isZero
        ).to(beFalse())
        
        expect(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: 0,
                    longitude: 0
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: 1,
                    longitudeDelta: 0
                )
            )
            .isZero
        ).to(beFalse())
        
        expect(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: 0,
                    longitude: 0
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: 0,
                    longitudeDelta: 1
                )
            )
            .isZero
        ).to(beFalse())
        
    }
    
}
