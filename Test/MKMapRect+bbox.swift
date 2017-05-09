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
        
        let zeroDecimalPattern = "(?:\\.?0\\d+)?"
        let zeroDigitPattern = "0*"
        
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
        ).to(match(String(
            format:"1%1$@,2%1$@,1.5%2$@,2.6%2$@",
            zeroDecimalPattern,
            zeroDigitPattern
        )))
        
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
        ).to(match(String(
            format:"1.1%1$@,2.2%1$@,2.1%1$@,4.2%1$@",
            zeroDigitPattern
        )))
        
    }
    
}
