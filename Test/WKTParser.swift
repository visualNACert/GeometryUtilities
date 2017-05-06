//
//  WKTParser.swift
//  Example
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 6/5/17.
//
//

import XCTest
import GeometryUtilities
import Nimble
import MapKit

class WKTParserTest: XCTestCase {

    fileprivate func exists(
        _ needle: CLLocationCoordinate2D,
        in haystack: [CLLocationCoordinate2D]
    ) -> Bool {
        return haystack.reduce(false) {
            return $0 || (
                abs($1.latitude - needle.latitude) < 0.1 &&
                abs($1.longitude - needle.longitude) < 0.1
            )
        }
    }

    func test__wkt_minMaxLatLon() {

        let polygonAWKT = "MULTIPOLYGON(((0.0 0.0, 0.0 1.0, 1.0 1.0, 1.0 0.0)))"

        let polygonAmmll = WKT.minMaxLatLon(of: polygonAWKT)

        expect(polygonAmmll.minLat).to(beCloseTo(0, within: 0.1))
        expect(polygonAmmll.minLon).to(beCloseTo(0, within: 0.1))
        expect(polygonAmmll.maxLat).to(beCloseTo(1, within: 0.1))
        expect(polygonAmmll.maxLon).to(beCloseTo(1, within: 0.1))
        expect(polygonAmmll.centroidLat).to(beCloseTo(0.5, within: 0.1))
        expect(polygonAmmll.centroidLon).to(beCloseTo(0.5, within: 0.1))
        expect(polygonAmmll.pointCount).to(equal(4))

        let polygonBWKT = "MULTIPOLYGON(((8.0 6.0, 10.0 9.0, 7.0 11.0, 8.0 6.0)))"

        let polygonBmmll = WKT.minMaxLatLon(of: polygonBWKT)

        expect(polygonBmmll.minLat).to(beCloseTo(6, within: 0.1))
        expect(polygonBmmll.minLon).to(beCloseTo(7, within: 0.1))
        expect(polygonBmmll.maxLat).to(beCloseTo(11, within: 0.1))
        expect(polygonBmmll.maxLon).to(beCloseTo(10, within: 0.1))
        expect(polygonBmmll.centroidLat).to(beCloseTo(8, within: 0.1))
        expect(polygonBmmll.centroidLon).to(beCloseTo(8.25, within: 0.1))
        expect(polygonBmmll.pointCount).to(equal(4))

        let multipolygonWKT = "MULTIPOLYGON(((0 0, 0 1, 1 1, 1 0)), ((8 6, 10 9, 7 11, 8 6)))"

        let multipolygonmmll = WKT.minMaxLatLon(of: multipolygonWKT)

        expect(multipolygonmmll.minLat).to(beCloseTo(0, within: 0.1))
        expect(multipolygonmmll.minLon).to(beCloseTo(0, within: 0.1))
        expect(multipolygonmmll.maxLat).to(beCloseTo(11, within: 0.1))
        expect(multipolygonmmll.maxLon).to(beCloseTo(10, within: 0.1))
        expect(multipolygonmmll.centroidLat).to(beCloseTo(4.25, within: 0.1))
        expect(multipolygonmmll.centroidLon).to(beCloseTo(4.375, within: 0.1))
        expect(multipolygonmmll.pointCount).to(equal(8))

    }

    func test__wkt_polygons() {

        let polygonACoordinates = [
            CLLocationCoordinate2D(
                latitude: 0,
                longitude: 0
            ),
            CLLocationCoordinate2D(
                latitude: 1,
                longitude: 0
            ),
            CLLocationCoordinate2D(
                latitude: 1,
                longitude: 1
            ),
            CLLocationCoordinate2D(
                latitude: 0,
                longitude: 1
            )
        ]

        let polygonAWKT = "MULTIPOLYGON(((0.0 0.0, 0.0 1.0, 1.0 1.0, 1.0 0.0)))"

        let polygonsA = WKT.polygons(in: polygonAWKT)
        expect(polygonsA).to(haveCount(1))
        expect(polygonsA.first).toNot(beNil())
        let polygonA = polygonsA.first!
        let polygonACoords = polygonA.coordinates()

        for coord in polygonACoords {
            expect(self.exists(coord, in: polygonACoordinates)).to(beTrue())
        }
        for coord in polygonACoordinates {
            expect(self.exists(coord, in: polygonACoords)).to(beTrue())
        }

        let polygonBCoordinates = [
            CLLocationCoordinate2D(
                latitude: 6,
                longitude: 8
            ),
            CLLocationCoordinate2D(
                latitude: 9,
                longitude: 10
            ),
            CLLocationCoordinate2D(
                latitude: 11,
                longitude: 7
            ),
            CLLocationCoordinate2D(
                latitude: 6,
                longitude: 8
            )
        ]

        let polygonBWKT = "MULTIPOLYGON(((8.0 6.0, 10.0 9.0, 7.0 11.0, 8.0 6.0)))"

        let polygonsB = WKT.polygons(in: polygonBWKT)
        expect(polygonsB).to(haveCount(1))
        expect(polygonsB.first).toNot(beNil())
        let polygonB = polygonsB.first!
        let polygonBCoords = polygonB.coordinates()

        for coord in polygonBCoords {
            expect(self.exists(coord, in: polygonBCoordinates)).to(beTrue())
        }
        for coord in polygonBCoordinates {
            expect(self.exists(coord, in: polygonBCoords)).to(beTrue())
        }

        let multipolygonCoordinates = [
            polygonACoordinates,
            polygonBCoordinates
        ].joined().map { $0 }

        let multipolygonWKT = "MULTIPOLYGON(((0 0, 0 1, 1 1, 1 0)), ((8 6, 10 9, 7 11, 8 6)))"

        let multipolygon = WKT.polygons(in: multipolygonWKT)
        expect(multipolygon).to(haveCount(2))
        let multipolygonCoords = multipolygon.map { $0.coordinates() }.joined().map { $0 }

        for coord in multipolygonCoords {
            expect(self.exists(coord, in: multipolygonCoordinates)).to(beTrue())
        }
        for coord in multipolygonCoordinates {
            expect(self.exists(coord, in: multipolygonCoords)).to(beTrue())
        }

    }

    func test__empty_collection_wktMultipolygonString() {

        let polygons: [MKPolygon] = []

        expect(polygons.wktMultipolygonString()).to(equal(""))

    }

    func test__collection_wktMultipolygonString() {

        let polygons = [
            MKPolygon(
                coordinates: [
                    CLLocationCoordinate2D(
                        latitude: 0,
                        longitude: 0
                    ),
                    CLLocationCoordinate2D(
                        latitude: 1,
                        longitude: 0
                    ),
                    CLLocationCoordinate2D(
                        latitude: 1,
                        longitude: 1
                    ),
                    CLLocationCoordinate2D(
                        latitude: 0,
                        longitude: 1
                    )
                ]
            ),
            MKPolygon(
                coordinates: [
                    CLLocationCoordinate2D(
                        latitude: 6,
                        longitude: 8
                    ),
                    CLLocationCoordinate2D(
                        latitude: 9,
                        longitude: 10
                    ),
                    CLLocationCoordinate2D(
                        latitude: 11,
                        longitude: 7
                    ),
                    CLLocationCoordinate2D(
                        latitude: 6,
                        longitude: 8
                    )
                ]
            )
        ]

        let smallDeltaPattern = "(0+[0-9]?)?"
        expect(polygons.wktMultipolygonString()).to(match(
            String(
                format: "MULTIPOLYGON\\(\\(\\(0.%1$@ 0.%1$@, 0.%1$@ 1.%1$@, 1.%1$@ 1.%1$@, 1.%1$@ 0.%1$@\\)\\), \\(\\(8.%1$@ 6.%1$@, 10.%1$@ 9.%1$@, 7.%1$@ 11.%1$@, 8.%1$@ 6.%1$@\\)\\)\\)",
                smallDeltaPattern
            )
        ))

    }

    func test__parseWKT() {

        let polygonACoordinates = [
            CLLocationCoordinate2D(
                latitude: 0,
                longitude: 0
            ),
            CLLocationCoordinate2D(
                latitude: 1,
                longitude: 0
            ),
            CLLocationCoordinate2D(
                latitude: 1,
                longitude: 1
            ),
            CLLocationCoordinate2D(
                latitude: 0,
                longitude: 1
            )
        ]

        let polygonAWKT = "MULTIPOLYGON(((0.0 0.0, 0.0 1.0, 1.0 1.0, 1.0 0.0)))"

        let polygonAmmll = parseWKT(polygonAWKT)

        expect(polygonAmmll.minLat).to(beCloseTo(0, within: 0.1))
        expect(polygonAmmll.minLon).to(beCloseTo(0, within: 0.1))
        expect(polygonAmmll.maxLat).to(beCloseTo(1, within: 0.1))
        expect(polygonAmmll.maxLon).to(beCloseTo(1, within: 0.1))
        expect(polygonAmmll.centroidLat).to(beCloseTo(0.5, within: 0.1))
        expect(polygonAmmll.centroidLon).to(beCloseTo(0.5, within: 0.1))
        expect(polygonAmmll.pointCount).to(equal(4))

        let polygonBCoordinates = [
            CLLocationCoordinate2D(
                latitude: 6,
                longitude: 8
            ),
            CLLocationCoordinate2D(
                latitude: 9,
                longitude: 10
            ),
            CLLocationCoordinate2D(
                latitude: 11,
                longitude: 7
            ),
            CLLocationCoordinate2D(
                latitude: 6,
                longitude: 8
            )
        ]

        let polygonBWKT = "MULTIPOLYGON(((8.0 6.0, 10.0 9.0, 7.0 11.0, 8.0 6.0)))"

        let polygonBmmll = parseWKT(polygonBWKT)

        expect(polygonBmmll.minLat).to(beCloseTo(6, within: 0.1))
        expect(polygonBmmll.minLon).to(beCloseTo(7, within: 0.1))
        expect(polygonBmmll.maxLat).to(beCloseTo(11, within: 0.1))
        expect(polygonBmmll.maxLon).to(beCloseTo(10, within: 0.1))
        expect(polygonBmmll.centroidLat).to(beCloseTo(8, within: 0.1))
        expect(polygonBmmll.centroidLon).to(beCloseTo(8.25, within: 0.1))
        expect(polygonBmmll.pointCount).to(equal(4))

        let multipolygonWKT = "MULTIPOLYGON(((0 0, 0 1, 1 1, 1 0)), ((8 6, 10 9, 7 11, 8 6)))"

        let multipolygonmmll = parseWKT(multipolygonWKT)

        expect(multipolygonmmll.minLat).to(beCloseTo(0, within: 0.1))
        expect(multipolygonmmll.minLon).to(beCloseTo(0, within: 0.1))
        expect(multipolygonmmll.maxLat).to(beCloseTo(11, within: 0.1))
        expect(multipolygonmmll.maxLon).to(beCloseTo(10, within: 0.1))
        expect(multipolygonmmll.centroidLat).to(beCloseTo(4.25, within: 0.1))
        expect(multipolygonmmll.centroidLon).to(beCloseTo(4.375, within: 0.1))
        expect(multipolygonmmll.pointCount).to(equal(8))

    }

    func test__polygonsInWKT() {

        let polygonACoordinates = [
            CLLocationCoordinate2D(
                latitude: 0,
                longitude: 0
            ),
            CLLocationCoordinate2D(
                latitude: 1,
                longitude: 0
            ),
            CLLocationCoordinate2D(
                latitude: 1,
                longitude: 1
            ),
            CLLocationCoordinate2D(
                latitude: 0,
                longitude: 1
            )
        ]

        let polygonAWKT = "MULTIPOLYGON(((0.0 0.0, 0.0 1.0, 1.0 1.0, 1.0 0.0)))"

        let polygonsA = polygonsInWKT(polygonAWKT)
        expect(polygonsA).to(haveCount(1))
        expect(polygonsA.first).toNot(beNil())
        let polygonA = polygonsA.first!
        let polygonACoords = polygonA.coordinates()

        for coord in polygonACoords {
            expect(self.exists(coord, in: polygonACoordinates)).to(beTrue())
        }
        for coord in polygonACoordinates {
            expect(self.exists(coord, in: polygonACoords)).to(beTrue())
        }

        let polygonBCoordinates = [
            CLLocationCoordinate2D(
                latitude: 6,
                longitude: 8
            ),
            CLLocationCoordinate2D(
                latitude: 9,
                longitude: 10
            ),
            CLLocationCoordinate2D(
                latitude: 11,
                longitude: 7
            ),
            CLLocationCoordinate2D(
                latitude: 6,
                longitude: 8
            )
        ]

        let polygonBWKT = "MULTIPOLYGON(((8.0 6.0, 10.0 9.0, 7.0 11.0, 8.0 6.0)))"

        let polygonsB = polygonsInWKT(polygonBWKT)
        expect(polygonsB).to(haveCount(1))
        expect(polygonsB.first).toNot(beNil())
        let polygonB = polygonsB.first!
        let polygonBCoords = polygonB.coordinates()

        for coord in polygonBCoords {
            expect(self.exists(coord, in: polygonBCoordinates)).to(beTrue())
        }
        for coord in polygonBCoordinates {
            expect(self.exists(coord, in: polygonBCoords)).to(beTrue())
        }

        let multipolygonCoordinates = [
            polygonACoordinates,
            polygonBCoordinates
        ].joined().map { $0 }

        let multipolygonWKT = "MULTIPOLYGON(((0 0, 0 1, 1 1, 1 0)), ((8 6, 10 9, 7 11, 8 6)))"

        let multipolygon = polygonsInWKT(multipolygonWKT)
        expect(multipolygon).to(haveCount(2))
        let multipolygonCoords = multipolygon.map { $0.coordinates() }.joined().map { $0 }

        for coord in multipolygonCoords {
            expect(self.exists(coord, in: multipolygonCoordinates)).to(beTrue())
        }
        for coord in multipolygonCoordinates {
            expect(self.exists(coord, in: multipolygonCoords)).to(beTrue())
        }

    }

}
