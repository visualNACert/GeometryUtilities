//
//  MultiPolygonRenderer.swift
//  Visual
//
//  Created by Lluís Ulzurrun on 20/7/16.
//  Copyright © 2016 VisualNACert. All rights reserved.
//

import MapKit


public class MultiPolygonRenderer: MKOverlayPathRenderer {

	/// Polygons to be drawn.
	private let polygons: [MKPolygon]

	/**
	 Creates a new renderer that can render a `MultiPolygonOverlay`.

	 - parameter multiPolygonOverlay:   `MultiPolygonOverlay` to be rendered.
	 - parameter useSimplifiedGeometry: Whether simplified geometry should be
	 used (`true`) or real, complex one (`false`).

	 - returns: Renderer that can render given multi polygon overlay.
	 */
	public init(multiPolygonOverlay: MultiPolygonOverlay, useSimplifiedGeometry: Bool = false) {

		if useSimplifiedGeometry {
			self.polygons = [multiPolygonOverlay.simplifiedPolygon]
		} else {
			self.polygons = multiPolygonOverlay.polygons
		}

		super.init(overlay: multiPolygonOverlay)

		// TODO: Move this display settings to a proxy object so they can be easily changed or themed
		if multiPolygonOverlay.selected {
			self.fillColor = UIColor.yellowColor()
			self.strokeColor = UIColor.blueColor()
		} else {
			self.fillColor = UIColor.redColor()
			self.strokeColor = UIColor.greenColor()
		}

		self.lineWidth = 5.0
	}

	private override init(overlay: MKOverlay) {
		self.polygons = []
		super.init(overlay: overlay)
	}

	public override func drawMapRect(mapRect: MKMapRect, zoomScale: MKZoomScale, inContext context: CGContext) {
		// Taken from: http://stackoverflow.com/a/17673411

		for polygon in self.polygons {
			guard let path = self.polyPathForPolygon(polygon) else { continue }
			self.applyFillPropertiesToContext(context, atZoomScale: zoomScale)
			CGContextBeginPath(context)
			CGContextAddPath(context, path)
			CGContextDrawPath(context, CGPathDrawingMode.EOFill)
			self.applyStrokePropertiesToContext(context, atZoomScale: zoomScale)
			CGContextBeginPath(context)
			CGContextAddPath(context, path)
			CGContextStrokePath(context)
		}

	}

	// MARK: Public helpers

	/**
	 Returns whether given point is found inside this renderer's polygons or not.

	 - parameter point: Map point to look for.

	 - returns: `true` if point is contained in this renderer`s polygons.
	 */
	public func containsPoint(point: MKMapPoint) -> Bool {
		// Taken from: http://stackoverflow.com/a/15235844

		let polygonViewPoint = self.pointForMapPoint(point)
		for polygon in self.polygons {

			guard CGPathContainsPoint(
				self.polyPathForPolygon(polygon),
				nil,
				polygonViewPoint,
				false
			) else { continue }

			// TODO: Check interior polygons to discard false positives

			return true

		}
		return false
	}

}
