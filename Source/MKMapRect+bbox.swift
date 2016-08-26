//
//  MKMapRect+bbox.swift
//  Visual
//
//  Created by Lluís Ulzurrun on 5/7/16.
//  Copyright © 2016 VisualNACert. All rights reserved.
//

import MapKit

extension MKMapRect {

	/// Returns bbox of this map rect.
	public var bbox: String {
		get {
			return "\(MKMapRectGetMinX(self)),\(MKMapRectGetMinY(self)),\(MKMapRectGetMaxX(self)),\(MKMapRectGetMaxY(self))"
		}
	}

}