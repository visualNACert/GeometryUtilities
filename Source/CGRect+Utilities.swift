//
//  CGRect+Utilities.swift
//  Visual
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
public func CGRectMake(center center: CGPoint, span: CGSize) -> CGRect {
	return CGRectMake(
		center.x - span.width / 2,
		center.y - span.height / 2,
		span.width,
		span.height
	)
}

extension CGRect {

	/// Point located at minimum X and Y values of this rect.
	public var minPoint: CGPoint {
		get {
			return CGPointMake(CGRectGetMinX(self), CGRectGetMinY(self))
		}
	}

	/// Point located at maximum X and Y values of this rect.
	public var maxPoint: CGPoint {
		get {
			return CGPointMake(CGRectGetMaxX(self), CGRectGetMaxY(self))
		}
	}

}