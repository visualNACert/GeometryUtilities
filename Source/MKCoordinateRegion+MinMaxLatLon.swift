//
//  MKCoordinateRegion+MinMaxLatLon.swift
//  Visual
//
//  Created by Lluís Ulzurrun on 20/7/16.
//  Copyright © 2016 VisualNACert. All rights reserved.
//

import Foundation

extension MKCoordinateRegion {

	/// Minimum and maximum latitude and longitude of this region.
	public var minMaxLatLon: MinMaxLonLat {
		get {
			return MinMaxLonLat(
				minLon: self.center.longitude - self.span.longitudeDelta / 2,
				minLat: self.center.latitude - self.span.latitudeDelta / 2,
				maxLon: self.center.longitude + self.span.longitudeDelta / 2,
				maxLat: self.center.latitude + self.span.latitudeDelta / 2,
				pointCount: 4
			)
		}
	}

}

extension MinMaxLonLat {

	public var coordinateRegion: MKCoordinateRegion {
		get {

			let minCoordinate = CLLocationCoordinate2DMake(
				self.maxLat,
				self.maxLon
			)

			let maxCoordinate = CLLocationCoordinate2DMake(
				self.minLat,
				self.minLon
			)

			let center = (minCoordinate + maxCoordinate) / 2.0

			let span = abs(maxCoordinate - minCoordinate)

			return MKCoordinateRegionMake(
				center,
				MKCoordinateSpan(
					latitudeDelta: span.latitude,
					longitudeDelta: span.longitude
				)
			)

		}
	}

}