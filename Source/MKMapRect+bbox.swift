//
//  MKMapRect+bbox.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun on 5/7/16.
//  Copyright © 2016 VisualNACert. All rights reserved.
//

import MapKit

extension MKMapRect {

	/// Returns bounding box of this map rect as a string.
	public var bbox: String {
        return [
            MKMapRectGetMinX(self),
            MKMapRectGetMinY(self),
            MKMapRectGetMaxX(self),
            MKMapRectGetMaxY(self)
        ].map { String(format: "%g", $0) }.joined(separator: ",")
	}

}
