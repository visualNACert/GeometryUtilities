//
//  MKMapSize+Area.swift
//  Visual
//
//  Created by Lluís Ulzurrun on 20/7/16.
//  Copyright © 2016 VisualNACert. All rights reserved.
//

import MapKit

extension MKMapSize {

	/// Area of this size.
	public var area: Double {
		get {
			return self.width * self.height
		}
	}

}
