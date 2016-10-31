//
//  MKPolygon+Coordinates.swift
//  Pods
//
//  Created by Lluís Ulzurrun on 31/10/16.
//
//

import MapKit

extension MKPolygon {

	/// Returns coordinates of points of this polygon.
	public func coordinates() -> [CLLocationCoordinate2D] {
		var coords = [CLLocationCoordinate2D](
			count: self.pointCount,
			repeatedValue: CLLocationCoordinate2DZero
		)
		self.getCoordinates(
			&coords,
			range: NSRange(location: 0, length: self.pointCount)
		)
		return coords
	}

	/// Creates a new polygon with given coordinates.
	public convenience init(coordinates: [CLLocationCoordinate2D]) {
		var copy = coordinates
		self.init(coordinates: &copy, count: copy.count)
	}

}
