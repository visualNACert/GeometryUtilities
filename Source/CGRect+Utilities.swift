//
//  CGRect+Utilities.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun on 21/7/16.
//  Copyright © 2016 VisualNACert. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGRect {
    /**
     Creates a new rect with given center and size.

     - parameter center: Center of the rectangle.
     - parameter size: Size of the rectangle.

     - returns: Properly initialized instance.
     */
    @available(*, introduced: 0.0.8)
    public init(center: CGPoint, size: CGSize) {
        self.init(
            origin: CGPoint(
                x: center.x - size.width / 2,
                y: center.y - size.height / 2
            ),
            size: size
        )
    }
}

extension CGRect {

	/// Point located at minimum X and Y values of this rect.
	public var minPoint: CGPoint {
		get {
			return CGPoint(x: self.minX, y: self.minY)
		}
	}

	/// Point located at maximum X and Y values of this rect.
	public var maxPoint: CGPoint {
		get {
			return CGPoint(x: self.maxX, y: self.maxY)
		}
	}

}
