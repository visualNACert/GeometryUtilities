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
		get {
            #if swift(>=3.0)
            return [
                MKMapRectGetMinX(self),
                MKMapRectGetMinY(self),
                MKMapRectGetMaxX(self),
                MKMapRectGetMaxY(self)
            ].map { "\($0)" }.joined(separator: ",")
            #else
			return "\(MKMapRectGetMinX(self)),\(MKMapRectGetMinY(self)),\(MKMapRectGetMaxX(self)),\(MKMapRectGetMaxY(self))"
            #endif
		}
	}

}
