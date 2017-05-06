//
//  MKCoordinateRegion+isValid.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 5/5/17.
//
//

import XCTest
import GeometryUtilities
import Nimble
import MapKit

class MKCoordinateRegionIsValidTest: XCTestCase {
    
    fileprivate func region(
        latitude: CLLocationDegrees,
        longitude: CLLocationDegrees,
        latitudeDelta: CLLocationDegrees,
        longitudeDelta: CLLocationDegrees
    ) -> MKCoordinateRegion {
        
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: latitude,
                longitude: longitude
            ),
            span: MKCoordinateSpan(
                latitudeDelta: latitudeDelta,
                longitudeDelta: longitudeDelta
            )
        )
        
    }
    
    func test__valid_region_is_detected() {
        
        
        expect(
            self.region(
                latitude: 0,
                longitude: 0,
                latitudeDelta: 0,
                longitudeDelta: 0
            ).valid
        ).to(beTrue())
        
        expect(
            self.region(
                latitude: -90.0,
                longitude: -180.0,
                latitudeDelta: 180.0,
                longitudeDelta: 360.0
            ).valid
        ).to(beTrue())
        
        expect(
            self.region(
                latitude: 39.58957,
                longitude: -0.33242,
                latitudeDelta: 0.0001,
                longitudeDelta: 0.0001
            ).valid
        ).to(beTrue())
        
    }
    
    func test__invalid_region_is_detected() {
        
        expect(
            self.region(
                latitude: -91,
                longitude: 0,
                latitudeDelta: 0,
                longitudeDelta: 0
            ).valid
        ).to(beFalse())
        
        expect(
            self.region(
                latitude: 0,
                longitude: -181,
                latitudeDelta: 0,
                longitudeDelta: 0
            ).valid
        ).to(beFalse())
        
        expect(
            self.region(
                latitude: 0,
                longitude: 0,
                latitudeDelta: -1,
                longitudeDelta: 0
            ).valid
        ).to(beFalse())
        
        expect(
            self.region(
                latitude: 0,
                longitude: 0,
                latitudeDelta: 0,
                longitudeDelta: -1
            ).valid
        ).to(beFalse())
        
    }
    
}
