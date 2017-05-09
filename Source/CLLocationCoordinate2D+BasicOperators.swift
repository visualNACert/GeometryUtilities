//
//  CLLocationCoordinate2D+BasicOperators.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun on 19/7/16.
//

import MapKit

extension CLLocationCoordinate2D: Equatable {

    /// Compares two coordinates and returns true if their latitude and
    /// longitudes are equal.
    public static func == (
        left: CLLocationCoordinate2D,
        right: CLLocationCoordinate2D
    ) -> Bool {
        return (
            left.latitude == right.latitude &&
            left.longitude == right.longitude
        )
    }

    /// Adds two coordinates, returning the coordinate resulting of adding each
    /// component independently.
    public static func + (
        left: CLLocationCoordinate2D,
        right: CLLocationCoordinate2D
    ) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: left.latitude + right.latitude,
            longitude: left.longitude + right.longitude
        )
    }

    /// Subtracts two coordinates, returning the coordinate resulting of subtracting
    /// each component independently.
    public static func - (
        left: CLLocationCoordinate2D,
        right: CLLocationCoordinate2D
    ) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: left.latitude - right.latitude,
            longitude: left.longitude - right.longitude
        )
    }

    /// Returns the coordinate resulting of dividing each component by given numeric
    /// value as a floating point number.
    public static func / (
        left: CLLocationCoordinate2D,
        right: Int
    ) -> CLLocationCoordinate2D {
        return left / Double(right)
    }

    /// Returns the coordinate resulting of dividing each component by given
    /// floating point number.
    public static func / (
        left: CLLocationCoordinate2D,
        right: Double
    ) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: left.latitude / right,
            longitude: left.longitude / right
        )
    }

    /// Returns the coordinate resulting of multiplying each component by given
    /// numeric value as a floating point number.
    public static func * (
        left: CLLocationCoordinate2D,
        right: Int
    ) -> CLLocationCoordinate2D {
        return left * Double(right)
    }

    /// Returns the coordinate resulting of multiplying each component by given
    /// floating point number.
    public static func * (
        left: CLLocationCoordinate2D,
        right: Double
    ) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(
            latitude: left.latitude * right,
            longitude: left.longitude * right
        )
    }

}

/// Returns location coordinate corresponding to given coordinate ignoring
/// latitude's and longitude's signs.
public func abs(_ value: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
	return CLLocationCoordinate2D(
        latitude: abs(value.latitude),
        longitude: abs(value.longitude)
    )
}

extension CLLocationCoordinate2D {

	/**
     Returns distance from this coordinate to given one.

     - parameter coordinate: Coordinate to which distance will be computed.

     - returns: Distance using Pytagora's theorem.
     */
    @available(*, introduced: 1.2.0)
	public func distance(to coordinate: CLLocationCoordinate2D) -> Double {
		let delta = self - coordinate
		return sqrt(
			delta.latitude * delta.latitude + delta.longitude * delta.longitude
		)
	}

}

extension Collection
where
    Iterator.Element == CLLocationCoordinate2D,
    IndexDistance == Int,
    SubSequence.Iterator.Element == CLLocationCoordinate2D
{

	/**
	 Returns centroid of polygon with this list of coordinates.

	 - returns: Centroid of polygon formed by this list of coordinates.
	 */
	public func centroid() -> CLLocationCoordinate2D {
		guard self.count > 0 else { return kCLLocationCoordinate2DInvalid }
		return self.reduce(CLLocationCoordinate2D.zero) { $0 + $1 } / self.count
	}
    
    /**
     Returns `MinMaxLonLat` of this collection's coordinates.
     
     - returns: `MinMaxLonLat` of this collection's coordinates. Will return
     `nil` iff there are no coordinates in this collection.
     */
    public func minMaxLatLon() -> MinMaxLatLon? {
        
        guard let first = self.first else { return nil }
        
        let tail = self.dropFirst()
        
        let latitudes = tail.map { $0.latitude }
        let longitudes = tail.map { $0.longitude }
        
        let minLat = latitudes.reduce(first.latitude, Swift.min)
        let minLon = longitudes.reduce(first.longitude, Swift.min)
        let maxLat = latitudes.reduce(first.latitude, Swift.max)
        let maxLon = longitudes.reduce(first.longitude, Swift.max)
        
        let centroid = self.centroid()
        
        return MinMaxLatLon(
            minLat: minLat,
            minLon: minLon,
            maxLat: maxLat,
            maxLon: maxLon,
            centroidLat: centroid.latitude,
            centroidLon: centroid.longitude,
            pointCount: Int32(self.count)
        )
        
    }
    
}
