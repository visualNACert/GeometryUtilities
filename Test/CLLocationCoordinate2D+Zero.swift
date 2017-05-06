//
//  CLLocationCoordinate2D+Zero.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 5/5/17.
//
//

import XCTest
import GeometryUtilities
import Nimble

class CLLocationCoordinate2DZeroTest: XCTestCase {
    
    func test__non_zero_is_detected() {
        
        let firstCoordinate = CLLocationCoordinate2D(
            latitude: 2.5,
            longitude: 3.7
        )
        
        expect(firstCoordinate.isZero).to(beFalse())
        
    }
    
    func test__zero_is_detected() {
        
        let firstCoordinate = CLLocationCoordinate2D(
            latitude: 0,
            longitude: 0
        )
        
        expect(firstCoordinate.isZero).to(beTrue())
        
    }
    
}
