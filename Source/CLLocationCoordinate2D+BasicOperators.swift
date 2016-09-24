//
//  CLLocationCoordinate2D+BasicOperators.swift
//  GeometryUtilities
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

/// Adds two coordinates, returning the coordinate resulting of adding each 
/// component independently.
public func + (
	left: CLLocationCoordinate2D,
	right: CLLocationCoordinate2D
) -> CLLocationCoordinate2D {
	return CLLocationCoordinate2DMake(
		left.latitude + right.latitude,
		left.longitude + right.longitude
	)
}

/// Subtracts two coordinates, returning the coordinate resulting of subtracting 
/// each component independently.
public func - (
	left: CLLocationCoordinate2D,
	right: CLLocationCoordinate2D
) -> CLLocationCoordinate2D {
	return CLLocationCoordinate2DMake(
		left.latitude - right.latitude,
		left.longitude - right.longitude
	)
}

/// Returns the coordinate resulting of dividing each component by given numeric
/// value as a floating point number.
public func / (
	left: CLLocationCoordinate2D,
	right: Int
) -> CLLocationCoordinate2D {
	return left / Double(right)
}

/// Returns the coordinate resulting of dividing each component by given 
/// floating point number.
public func / (
	left: CLLocationCoordinate2D,
	right: Double
) -> CLLocationCoordinate2D {
	return CLLocationCoordinate2DMake(
		left.latitude / right,
		left.longitude / right
	)
}

extension CollectionType where Generator.Element == CLLocationCoordinate2D, Self.Index == Int {

	/**
	 Returns centroid of polygon with this list of coordinates.

	 - returns: Centroid of polygon formed by this list of coordinates.
	 */
	public func centroid() -> CLLocationCoordinate2D {
		guard self.count > 0 else { return kCLLocationCoordinate2DInvalid }
		return self.reduce(CLLocationCoordinate2DZero) { $0 + $1 } / self.count
	}

}
