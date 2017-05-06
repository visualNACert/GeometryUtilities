//
//  MKMapRect+bbox.swift
//  Example
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 5/5/17.
//
//

import XCTest
import GeometryUtilities
import Nimble
import MapKit

class MKMapRectbboxTest: XCTestCase {
    
    func test__bbox() {
        
        expect(
            MKMapRect(
                origin: MKMapPoint(
                    x: 1,
                    y: 2
                ),
                size: MKMapSize(
                    width: 0.5,
                    height: 0.6
                )
            ).bbox
        ).to(equal("1,2,1.5,2.6"))
        
        expect(
            MKMapRect(
                origin: MKMapPoint(
                    x: 1.1,
                    y: 2.2
                ),
                size: MKMapSize(
                    width: 1,
                    height: 2
                )
            ).bbox
        ).to(equal("1.1,2.2,2.1,4.2"))
        
    }
    
}
