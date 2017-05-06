//
//  MKMapSize+area.swift
//  Example
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 5/5/17.
//
//

import XCTest
import GeometryUtilities
import Nimble
import MapKit

class MKMapMapSizeAreaTest: XCTestCase {
    
    func test__area() {
        
        expect(
             MKMapSize(
                width: 0.5,
                height: 0.6
            ).area
        ).to(beCloseTo(0.3, within: 0.1))
        
    }
    
}
