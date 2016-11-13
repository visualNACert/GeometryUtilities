//
//  MKPolygon+CGPaths.swift
//  GeometryUtilities
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
    @available(*, introduced: 1.2.0)
    public func polyPath(for polygon: MKPolygon) -> CGPath? {
        return polygon.polyPath(for: self)
    }

	/**
	 Returns `CGPathRef` equivalent to given polygon in this renderer.

	 - parameter polygon: Polygon whose equivalent path will be returned.

	 - returns: Path equivalent to given polygon in this renderer.
	 */
    @available(*, introduced: 0.0.8, deprecated: 1.2.0, renamed: "polyPath(for:)")
    public func polyPath(forPolygon polygon: MKPolygon) -> CGPath? {
        return self.polyPath(for: polygon)
    }

}

extension MKPolygon {

	/**
	 Returns a `CGPathRef` equivalent to this polygon in given renderer.
     
     - note: [Source](http://stackoverflow.com/a/17673411).

	 - parameter renderer: Renderer defining coordinate system
     where returned path will be drawn.

	 - returns: Path equivalent to this polygon in given renderer.
	 */
    @available(*, introduced: 1.2.0)
	public func polyPath(for renderer: MKOverlayPathRenderer) -> CGPath? {

		let points = self.points()
		let pointsCount = self.pointCount

		guard pointCount >= 3 else { return nil }

		let path = CGMutablePath()

		if let interiorPolygons = self.interiorPolygons {
			for interiorPolygon in interiorPolygons {
                let pathToAdd = interiorPolygon.polyPath(
                    for: renderer
                )!
                path.addPath(pathToAdd)
			}
		}

		let relativePoint = renderer.point(for: points[0])
        path.move(to: relativePoint)
		for i in 1..<pointsCount {
			let nextPoint = renderer.point(for: points[i])
            path.addLine(to: nextPoint)
		}

		return path

	}
    
    /**
     Returns a `CGPathRef` equivalent to this polygon in given renderer.
     
     - note: [Source](http://stackoverflow.com/a/17673411).
     
     - parameter renderer: Renderer defining coordinate system
     where returned path will be drawn.
     
     - returns: Path equivalent to this polygon in given renderer.
     */
    @available(*, deprecated: 1.2.0, renamed: "polyPath(for:)")
    public func polyPath(
        forOverlayPathRenderer renderer: MKOverlayPathRenderer
    ) -> CGPath? {
        return self.polyPath(for: renderer)
    }

}
