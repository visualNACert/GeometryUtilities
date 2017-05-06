//
//  CGRect+Utilities.test.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 24/9/16.
//
//

import XCTest
import GeometryUtilities
import Nimble

class CGRectUtilitiesTest: XCTestCase {
    
    func test__CGRect_center_constructor() {
        
        let rect = CGRect(
            center: CGPoint(x: 5, y: 7),
            size: CGSize(width: 3, height: 1)
        )
        
        expect(rect.origin).to(equal(CGPoint(x: 3.5, y: 6.5)))
        expect(rect.size).to(equal(CGSize(width: 3, height: 1)))
        
    }
    
    func test__CGRect_minPoint() {
     
        let rect = CGRect(
            origin: CGPoint(x: 4, y: 9),
            size: CGSize(width: 2, height: 3)
        )
        
        expect(rect.minPoint).to(equal(CGPoint(x: 4, y: 9)))
        
    }
    
    func test__CGRect_maxPoint() {
        
        let rect = CGRect(
            origin: CGPoint(x: 4, y: 9),
            size: CGSize(width: 2, height: 3)
        )
        
        expect(rect.maxPoint).to(equal(CGPoint(x: 6, y: 12)))
        
    }
    
}
