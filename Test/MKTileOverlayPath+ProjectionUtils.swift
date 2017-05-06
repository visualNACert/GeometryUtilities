//
//  MKTileOverlayPath+ProjectionUtils.swift
//  Example
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 5/5/17.
//
//

import XCTest
import GeometryUtilities
import Nimble
import MapKit

class MKTileOverlayPathProjectionUtilsTest: XCTestCase {
    
    func test__bboxWGS84() {
        
        let tileOverlayPath = MKTileOverlayPath(
            x: 261658,
            y: 199264,
            z: 19,
            contentScaleFactor: 1.0
        )
        
        let expected = [
            -0.33371,
            39.5882,
            -0.333023,
            39.5888
        ].map { String(format: "%g", $0) }.joined(separator: ",")
        
        expect(tileOverlayPath.bboxWGS84).to(equal(expected))
        
    }
    
    func test__bboxMercator() {
        
        let tileOverlayPath = MKTileOverlayPath(
            x: 261658,
            y: 199264,
            z: 19,
            contentScaleFactor: 1.0
        )
        
        let expected = [
            -37148.3957414246,
            4806283.90087456,
            -37071.95871315,
            4806360.33790283
        ].map { String(format: "%g", $0) }.joined(separator: ",")
        
        expect(tileOverlayPath.bboxMercator).to(equal(expected))
        
    }
    
}
