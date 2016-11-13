//
//  MultiPolygonRenderer.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun on 20/7/16.
//  Copyright © 2016 VisualNACert. All rights reserved.
//

import MapKit

#if os(iOS)
import UIKit
public typealias Color = UIColor
#else
import AppKit
public typealias Color = NSColor
#endif

open class MultiPolygonRenderer: MKOverlayPathRenderer {

	/// Polygons to be drawn.
	fileprivate let polygons: [MKPolygon]

    /// Style information about how a multi polygon should render its shape.
    public typealias Style = (fill: Color, stroke: Color, width: CGFloat)
    
    /**
     Creates a new renderer that can render a `MultiPolygonOverlay`.
     
     - parameter multiPolygonOverlay: `MultiPolygonOverlay` to be rendered.
     - parameter normalStyle: Colors and stroke width to be used to draw polygon 
     when not selected.
     - parameter selectedStyle: Colors and stroke width to be used to draw 
     polygon when selected.
     - parameter useSimplifiedGeometry: Whether simplified geometry (bounding 
     box, `true`) or real, complex one (`false`) should be drawn.
     
     - returns: Renderer that can render given multi polygon overlay.
     */
    @available(*, introduced: 1.1.0)
    public init(
        multiPolygonOverlay: MultiPolygonOverlay,
        normalStyle: Style,
        selectedStyle: Style,
        useSimplifiedGeometry: Bool = false
    ) {
        
        if useSimplifiedGeometry {
            self.polygons = [multiPolygonOverlay.simplifiedPolygon]
        } else {
            self.polygons = multiPolygonOverlay.polygons
        }
        
        super.init(overlay: multiPolygonOverlay)
        
        // TODO: Move this display settings to a proxy object so they can be easily changed or themed
        let style = (multiPolygonOverlay.selected) ? selectedStyle : normalStyle
        
        self.fillColor = style.fill
        self.strokeColor = style.stroke
        self.lineWidth = style.width
        
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
            guard let path = self.polyPath(for: polygon) else { continue }
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
    @available(*, introduced: 1.2.0)
    open func contains(_ point: MKMapPoint) -> Bool {
        
        let polygonViewPoint = self.point(for: point)
        for polygon in self.polygons {
            
            guard let polypath = self.polyPath(for: polygon),
                polypath.contains(polygonViewPoint) else { continue }
            
            // TODO: Check interior polygons to discard false positives
            
            return true
            
        }
        return false
    }
    
    /**
     Returns whether given point is found inside this renderer's polygons or not.
     
     - note: [Source](http://stackoverflow.com/a/15235844)
     
     - parameter point: Map point to look for.
     
     - returns: `true` if point is contained in this renderer`s polygons.
     */
    @available(*, introduced: 1.1.0, deprecated: 1.2.0, renamed: "contains()")
    open func contains(point: MKMapPoint) -> Bool {
        return self.contains(point)
    }
    
    /**
     Returns whether given point is found inside this renderer's polygons or not.
     
     - parameter point: Map point to look for.
     
     - returns: `true` if point is contained in this renderer`s polygons.
     */
    @available(*, deprecated: 1.1.0, renamed: "contains(point:)")
	open func containsPoint(_ point: MKMapPoint) -> Bool {
        return self.contains(point: point)
	}

}
