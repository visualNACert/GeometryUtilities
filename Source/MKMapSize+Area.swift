//
//  MKMapSize+Area.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun on 20/7/16.
//

import MapKit

extension MKMapSize {

	/// Area of this size.
	public var area: Double {
        return self.width * self.height
	}

}
