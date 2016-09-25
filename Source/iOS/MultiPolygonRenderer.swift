//
//  MultiPolygonRenderer.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun on 20/7/16.
//  Copyright © 2016 VisualNACert. All rights reserved.
//

import MapKit
import UIKit

#if swift(>=3.0)

open class MultiPolygonRenderer: MKOverlayPathRenderer {

	/// Polygons to be drawn.
	fileprivate let polygons: [MKPolygon]

	/**
	 Creates a new renderer that can render a `MultiPolygonOverlay`.

	 - parameter multiPolygonOverlay: `MultiPolygonOverlay` to be rendered.
     - parameter fillColor: Color to be used to fill polygon.
     - parameter strokeColor: Color to be used to stroke polygon.
     - parameter selectedFillColor: Color to be used to fill polygon when
     selected.
     - parameter selectedStrokeColor: Color to be used to stroke polygon when
     selected.
	 - parameter useSimplifiedGeometry: Whether simplified geometry should be
	 used (`true`) or real, complex one (`false`).

	 - returns: Renderer that can render given multi polygon overlay.
	 */
	public init(
		multiPolygonOverlay: MultiPolygonOverlay,
		fillColor: UIColor,
		strokeColor: UIColor,
		selectedFillColor: UIColor,
		selectedStrokeColor: UIColor,
		useSimplifiedGeometry: Bool = false
	) {

		if useSimplifiedGeometry {
			self.polygons = [multiPolygonOverlay.simplifiedPolygon]
		} else {
			self.polygons = multiPolygonOverlay.polygons
		}

		super.init(overlay: multiPolygonOverlay)

		// TODO: Move this display settings to a proxy object so they can be easily changed or themed
		if multiPolygonOverlay.selected {
			self.fillColor = selectedFillColor
			self.strokeColor = selectedStrokeColor
		} else {
			self.fillColor = fillColor
			self.strokeColor = strokeColor
		}

		self.lineWidth = 5.0
	}

	fileprivate override init(overlay: MKOverlay) {
		self.polygons = []
		super.init(overlay: overlay)
	}

	open override func draw(
        _ mapRect: MKMapRect,
        zoomScale: MKZoomScale,
        in context: CGContext
    ) {
		// Taken from: http://stackoverflow.com/a/17673411

		for polygon in self.polygons {
            guard let path = self.polyPath(forPolygon: polygon) else { continue }
			self.applyFillProperties(to: context, atZoomScale: zoomScale)
			context.beginPath()
			context.addPath(path)
			context.drawPath(using: CGPathDrawingMode.eoFill)
			self.applyStrokeProperties(to: context, atZoomScale: zoomScale)
			context.beginPath()
			context.addPath(path)
			context.strokePath()
		}

	}

	// MARK: Public helpers

	/**
	 Returns whether given point is found inside this renderer's polygons or not.

     - note: [Source](http://stackoverflow.com/a/15235844)
     
	 - parameter point: Map point to look for.

	 - returns: `true` if point is contained in this renderer`s polygons.
	 */
	open func containsPoint(_ point: MKMapPoint) -> Bool {

		let polygonViewPoint = self.point(for: point)
		for polygon in self.polygons {

            guard let path = self.polyPath(forPolygon: polygon),
                path.contains(polygonViewPoint) else { continue }

			// TODO: Check interior polygons to discard false positives

			return true

		}
		return false
	}

}

#else

public class MultiPolygonRenderer: MKOverlayPathRenderer {
    
    /// Polygons to be drawn.
    private let polygons: [MKPolygon]
    
    /**
     Creates a new renderer that can render a `MultiPolygonOverlay`.
     
     - parameter multiPolygonOverlay:   `MultiPolygonOverlay` to be rendered.
     - parameter fillColor:             Color to be used to fill polygon.
     - parameter strokeColor:           Color to be used to stroke polygon.
     - parameter selectedFillColor:     Color to be used to fill polygon when
     selected.
     - parameter selectedStrokeColor:   Color to be used to stroke polygon when
     selected.
     - parameter useSimplifiedGeometry: Whether simplified geometry should be
     used (`true`) or real, complex one (`false`).
     
     - returns: Renderer that can render given multi polygon overlay.
     */
    public init(
        multiPolygonOverlay: MultiPolygonOverlay,
        fillColor: UIColor,
        strokeColor: UIColor,
        selectedFillColor: UIColor,
        selectedStrokeColor: UIColor,
        useSimplifiedGeometry: Bool = false
        ) {
        
        if useSimplifiedGeometry {
            self.polygons = [multiPolygonOverlay.simplifiedPolygon]
        } else {
            self.polygons = multiPolygonOverlay.polygons
        }
        
        super.init(overlay: multiPolygonOverlay)
        
        // TODO: Move this display settings to a proxy object so they can be easily changed or themed
        if multiPolygonOverlay.selected {
            self.fillColor = selectedFillColor
            self.strokeColor = selectedStrokeColor
        } else {
            self.fillColor = fillColor
            self.strokeColor = strokeColor
        }
        
        self.lineWidth = 5.0
    }
    
    private override init(overlay: MKOverlay) {
        self.polygons = []
        super.init(overlay: overlay)
    }
    
    public override func drawMapRect(
        mapRect: MKMapRect,
        zoomScale: MKZoomScale,
        inContext context: CGContext
        ) {
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
     
     - note: [Source](http://stackoverflow.com/a/15235844)
     
     - parameter point: Map point to look for.
     
     - returns: `true` if point is contained in this renderer`s polygons.
     */
    public func containsPoint(point: MKMapPoint) -> Bool {
        
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

#endif

