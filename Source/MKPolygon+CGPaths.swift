//
//  MKPolygon+CGPaths.swift
//  Visual
//
//  Created by Lluís Ulzurrun on 20/7/16.
//  Copyright © 2016 VisualNACert. All rights reserved.
//

import MapKit

extension MKOverlayPathRenderer {

	/**
	 Returns `CGPathRef` equivalent to given polygon in this renderer.

	 - parameter polygon: Polygon whose equivalent path will be returned.

	 - returns: Path equivalent to given polygon in this renderer.
	 */
	public func polyPathForPolygon(polygon: MKPolygon) -> CGPathRef? {
		return polygon.polyPathForOverlayPathRenderer(self)
	}

}

extension MKPolygon {

	/**
	 Returns a `CGPathRef` equivalent to this polygon in given renderer.

	 - parameter renderer: Renderer defining coordinate system where returned
	 path will be drawn.

	 - returns: Path equivalent to this polygon in given renderer.
	 */
	public func polyPathForOverlayPathRenderer(
		renderer: MKOverlayPathRenderer
	) -> CGPathRef? {

		// Taken from: http://stackoverflow.com/a/17673411

		let points = self.points()
		let pointsCount = self.pointCount

		guard pointCount >= 3 else { return nil }

		let path = CGPathCreateMutable()

		if let interiorPolygons = self.interiorPolygons {
			for interiorPolygon in interiorPolygons {
                let pathToAdd: CGPath
                #if swift(>=3.0)
                    pathToAdd = interiorPolygon
                        .polyPathForOverlayPathRenderer(renderer)
                #else
                    pathToAdd = interiorPolygon
                        .polyPathForOverlayPathRenderer(renderer)!
                #endif
                CGPathAddPath(path, nil, pathToAdd)
			}
		}

		let relativePoint = renderer.pointForMapPoint(points[0])
		CGPathMoveToPoint(path, nil, relativePoint.x, relativePoint.y)
		for i in 1..<pointsCount {
			let nextPoint = renderer.pointForMapPoint(points[i])
			CGPathAddLineToPoint(path, nil, nextPoint.x, nextPoint.y)
		}

		return path

	}

}
