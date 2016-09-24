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
    #if swift(>=3.0)
    @available(*, introduced: 0.0.8)
    public func polyPath(forPolygon polygon: MKPolygon) -> CGPath? {
        return polygon.polyPath(forOverlayPathRenderer: self)
    }
    #else
    public func polyPathForPolygon(polygon: MKPolygon) -> CGPath? {
        return polygon.polyPathForOverlayPathRenderer(self)
    }
    #endif

}

extension MKPolygon {

	/**
	 Returns a `CGPathRef` equivalent to this polygon in given renderer.
     
     - note: [Source](http://stackoverflow.com/a/17673411).

	 - parameter renderer: Renderer defining coordinate system where returned
	 path will be drawn.

	 - returns: Path equivalent to this polygon in given renderer.
	 */
    #if swift(>=3)
	public func polyPath(
        forOverlayPathRenderer renderer: MKOverlayPathRenderer
	) -> CGPath? {

		let points = self.points()
		let pointsCount = self.pointCount

		guard pointCount >= 3 else { return nil }

		let path = CGMutablePath()

		if let interiorPolygons = self.interiorPolygons {
			for interiorPolygon in interiorPolygons {
                let pathToAdd = interiorPolygon.polyPath(
                    forOverlayPathRenderer: renderer
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
    #else
    public func polyPathForOverlayPathRenderer(
        _ renderer: MKOverlayPathRenderer
    ) -> CGPath? {
        
        let points = self.points()
        let pointsCount = self.pointCount
        
        guard pointCount >= 3 else { return nil }
        
        let path = CGPathCreateMutable()
        
        if let interiorPolygons = self.interiorPolygons {
            for interiorPolygon in interiorPolygons {
                let pathToAdd = interiorPolygon
                    .polyPathForOverlayPathRenderer(renderer)!
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
    #endif

}
