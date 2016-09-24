//
//  CGRect+Utilities.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun on 21/7/16.
//  Copyright © 2016 VisualNACert. All rights reserved.
//

import Foundation
import CoreGraphics

/**
 Returns a new rect centered at given point with given span.

 - parameter center: Center of the rectangle.
 - parameter span:   Size of the rectangle.

 - returns: Rectangle with given size centered at given point.
 */
#if swift(>=3)
public func CGRectMake(center: CGPoint, span: CGSize) -> CGRect {
	return CGRect(
		x: center.x - span.width / 2,
		y: center.y - span.height / 2,
		width: span.width,
		height: span.height
	)
}
#else
public func CGRectMake(center center: CGPoint, span: CGSize) -> CGRect {
    return CGRectMake(
        center.x - span.width / 2,
        center.y - span.height / 2,
        span.width,
        span.height
    )
}
#endif

extension CGRect {

	/// Point located at minimum X and Y values of this rect.
	public var minPoint: CGPoint {
		get {
            #if swift(>=3)
			return CGPoint(x: self.minX, y: self.minY)
            #else
            return CGPointMake(CGRectGetMinX(self), CGRectGetMinY(self))
            #endif
		}
	}

	/// Point located at maximum X and Y values of this rect.
	public var maxPoint: CGPoint {
		get {
            #if swift(>=3)
			return CGPoint(x: self.maxX, y: self.maxY)
            #else
            return CGPointMake(CGRectGetMaxX(self), CGRectGetMaxY(self))
            #endif
		}
	}

}
