//
//  CLLocationCoordinate2D+BasicOperators.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 25/9/16.
//
//

import XCTest
import GeometryUtilities
import Nimble

class CLLocationCoordinate2DBasicOperatorsTest: XCTestCase {

    func test__equality() {
        
        let firstCoordinate = CLLocationCoordinate2D(
            latitude: 2.5,
            longitude: 3.7
        )
        let secondCoordinate = CLLocationCoordinate2D(
            latitude: 2.5,
            longitude: 3.7
        )
        let thirdCoordinate = CLLocationCoordinate2D(
            latitude: 3.7,
            longitude: 3.7
        )
        
        expect(firstCoordinate).to(equal(secondCoordinate))
        expect(secondCoordinate).to(equal(firstCoordinate))
        
        expect(firstCoordinate).toNot(equal(thirdCoordinate))
        expect(thirdCoordinate).toNot(equal(firstCoordinate))
        
        expect(secondCoordinate).toNot(equal(thirdCoordinate))
        expect(thirdCoordinate).toNot(equal(secondCoordinate))
        
    }
    
    func test__coordinateZero() {
        expect(CLLocationCoordinate2D.zero).to(
            equal(CLLocationCoordinate2D(latitude: 0, longitude: 0))
        )
    }
    
    func test__abs() {
        
        expect(abs(CLLocationCoordinate2D(
            latitude: 2,
            longitude: 0
        ))).to(equal(CLLocationCoordinate2D(latitude: 2, longitude: 0)))
        
        expect(abs(CLLocationCoordinate2D(
            latitude: -2,
            longitude: 2
        ))).to(equal(CLLocationCoordinate2D(latitude: 2, longitude: 2)))
        
        expect(abs(CLLocationCoordinate2D(
            latitude: -2,
            longitude: -0
        ))).to(equal(CLLocationCoordinate2D(latitude: 2, longitude: 0)))
        
        expect(abs(CLLocationCoordinate2D(
            latitude: -2,
            longitude: -1
        ))).to(equal(CLLocationCoordinate2D(latitude: 2, longitude: 1)))
        
    }

    func test__addition() {
        
        let firstCoordinate = CLLocationCoordinate2D(
            latitude: 2.764,
            longitude: 1.075
        )
        
        let secondCoordinate = CLLocationCoordinate2D(
            latitude: 0.232,
            longitude: 4.44
        )
        
        let result = firstCoordinate + secondCoordinate
        
        expect(result.latitude).to(beCloseTo(2.996, within: 0.1))
        expect(result.longitude).to(beCloseTo(5.519, within: 0.1))
        
    }
    
    func test__subtract() {
        
        let firstCoordinate = CLLocationCoordinate2D(
            latitude: 2.764,
            longitude: 1.075
        )
        
        let secondCoordinate = CLLocationCoordinate2D(
            latitude: 0.232,
            longitude: 4.44
        )
        
        let result = firstCoordinate - secondCoordinate
        
        expect(result.latitude).to(beCloseTo(2.532, within: 0.1))
        expect(result.longitude).to(beCloseTo(-3.365, within: 0.1))
        
    }
    
    func test__divide_integer() {
        
        let coordinate = CLLocationCoordinate2D(
            latitude: 5,
            longitude: 3.2
        ) / 2
        
        expect(coordinate.latitude).to(beCloseTo(2.5, within: 0.1))
        expect(coordinate.longitude).to(beCloseTo(1.6, within: 0.1))
        
        
    }
    
    func test__divide_double() {
     
        let coordinate = CLLocationCoordinate2D(
            latitude: 6.25,
            longitude: 10
        ) / 2.5
        
        expect(coordinate.latitude).to(beCloseTo(2.5, within: 0.1))
        expect(coordinate.longitude).to(beCloseTo(4, within: 0.1))
        
    }
    
    func test__multiply_integer() {
        
        let coordinate = CLLocationCoordinate2D(
            latitude: 5,
            longitude: 3.2
        ) * 2
        
        expect(coordinate.latitude).to(beCloseTo(10, within: 0.1))
        expect(coordinate.longitude).to(beCloseTo(6.4, within: 0.1))
        
        
    }
    
    func test__distance() {
        
        let start = CLLocationCoordinate2D(
            latitude: 0,
            longitude: 0
        )
        
        let end = CLLocationCoordinate2D(
            latitude: 4,
            longitude: 3
        )
        
        expect(start.distance(to: end)).to(beCloseTo(5, within: 0.1))
        expect(end.distance(to: start)).to(beCloseTo(5, within: 0.1))
        
    }
    
    func test__multiply_double() {
        
        let coordinate = CLLocationCoordinate2D(
            latitude: 6.25,
            longitude: 10
        ) * 2.5
        
        expect(coordinate.latitude).to(beCloseTo(15.625, within: 0.1))
        expect(coordinate.longitude).to(beCloseTo(25, within: 0.1))
        
    }
    
    func test__centroid() {
        
        let points = [(2, 7), (4, 3), (9, 2), (3.5, 2), (5, 5.5)].map {
            CLLocationCoordinate2D(latitude: $0, longitude: $1)
        }
        
        let centroid = points.centroid()
        
        expect(centroid.latitude).to(beCloseTo(4.7, within: 0.1))
        expect(centroid.longitude).to(beCloseTo(3.9, within: 0.1))
        
        
    }
    
    func test__invalid_centroid() {
        
        let points = [CLLocationCoordinate2D]()
        
        let centroid = points.centroid()
        
        expect(CLLocationCoordinate2DIsValid(centroid)).to(beFalse())
        
    }

}
