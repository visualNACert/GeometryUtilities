//
//  MinMaxLatLon.swift
//  Example
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 9/5/17.
//
//

import XCTest
import GeometryUtilities
import Nimble

class MinMaxLatLonTest: XCTestCase {
    
    func test__centroid() {
        
        let mmll = MinMaxLatLon(
            minLat: 1,
            minLon: 0,
            maxLat: 2,
            maxLon: 4,
            centroidLat: 1.5,
            centroidLon: 2,
            pointCount: 4
        )
        
        expect(mmll.centroid.latitude).to(beCloseTo(1.5, within: 0.1))
        expect(mmll.centroid.longitude).to(beCloseTo(2, within: 0.1))
        
    }
    
}
