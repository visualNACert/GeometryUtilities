//
//  CLLocationCoordinate2D+BasicOperators.swift
//  Visual
//
//  Created by Lluís Ulzurrun on 19/7/16.
//  Copyright © 2016 VisualNACert. All rights reserved.
//

import MapKit

/// Location coordinates for point at latitude and longitude 0.
public let CLLocationCoordinate2DZero = CLLocationCoordinate2DMake(0, 0)

public func abs(value: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
	return CLLocationCoordinate2DMake(abs(value.latitude), abs(value.longitude))
}

public func + (
	left: CLLocationCoordinate2D,
	right: CLLocationCoordinate2D
) -> CLLocationCoordinate2D {
	return CLLocationCoordinate2DMake(
		left.latitude + right.latitude,
		left.longitude + right.longitude
	)
}

public func - (
	left: CLLocationCoordinate2D,
	right: CLLocationCoordinate2D
) -> CLLocationCoordinate2D {
	return CLLocationCoordinate2DMake(
		left.latitude - right.latitude,
		left.longitude - right.longitude
	)
}

public func / (
	left: CLLocationCoordinate2D,
	right: Int
) -> CLLocationCoordinate2D {
	return left / Double(right)
}

public func / (
	left: CLLocationCoordinate2D,
	right: Double
) -> CLLocationCoordinate2D {
	return CLLocationCoordinate2DMake(
		left.latitude / right,
		left.longitude / right
	)
}

extension CLLocationCoordinate2D {

	/**
     Returns distance from this coordinate to given one.
     
     - parameter coordinate: Coordinate to which distance will be computed.
     
     - returns: Distance using Pytagora's theorem.
     */
	public func distance(
		toCoordinate coordinate: CLLocationCoordinate2D
	) -> Double {
		let delta = self - coordinate
		return sqrt(
			delta.latitude * delta.latitude + delta.longitude * delta.longitude
		)
	}

}

extension _ArrayType where Generator.Element == CLLocationCoordinate2D {

	/**
	 Returns centroid of polygon with this list of coordinates.

	 - returns: Centroid of polygon formed by this list of coordinates.
	 */
	public func centroid() -> CLLocationCoordinate2D {
		guard self.count > 0 else { return kCLLocationCoordinate2DInvalid }
		return self.reduce(CLLocationCoordinate2DZero) { $0 + $1 } / self.count
	}

}
