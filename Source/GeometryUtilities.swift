//
//  GeometryUtilities.swift
//  Visual
//
//  Created by Lluís Ulzurrun on 8/7/16.
//  Copyright © 2016 VisualNACert. All rights reserved.
//

import Foundation

public struct GeometryUtilities {

	/**
	 Returns minimum and maximum longitude and latitude of polygons in given
	 WKT geometry.

	 - note: Uses Objective-C implementation for effiency's sake.

	 - parameter wkt: Geometry to analyze.

	 - returns: Minimum and maximum longitude and latitude.
	 */
	public  static func minimumAndMaximumLongitudeAndLatitudeInWKTGeometry(
		wkt: String
	) -> (
		min: (lon: Double, lat: Double),
		max: (lon: Double, lat: Double),
		pointCount: Int
	) {
		let minMaxLonLat = parseWKT(wkt)
		return (
			min: (lon: minMaxLonLat.minLon, lat: minMaxLonLat.minLat),
			max: (lon: minMaxLonLat.maxLon, lat: minMaxLonLat.maxLat),
			pointCount: Int(minMaxLonLat.pointCount)
		)
	}

	/**
	 Returns minimum and maximum longitude and latitude of polygons in given
	 WKT geometry.

	 # Motivation

	 Initially retrieving minimum and maximum longitude and latitude was
	 performed using a regular expression. However this approach required a lot
	 of memory for both: pattern creation and matching.

	 This method uses a couple of for loops and required a lot less memory but
	 it's much less flexible and slower than regex-based one.

	 - note: Uses `for` loops instead of regex in its implementation.

	 - parameter wkt: Geometry to analyze.

	 - throws: Error when given geometry is not a valid WKT geometry.

	 - returns: Minimum and maximum longitude and latitude.
	 */
	private static func minimumAndMaximumLongitudeAndLatitudeInWKTGeometry_for_loops_implementation(wkt: String) throws ->
	(min: (lon: Double, lat: Double), max: (lon: Double, lat: Double)) {

		let charToDouble: (Character) -> Double = {
			return Double("\($0)") ?? (-1.0)
		}

		let isDigitOrMinus: (Character) -> Bool = {
			if $0 == "-" || charToDouble($0) >= 0 {
				return true
			} else {
				return false
			}
		}

		let isDigitOrDot: (Character) -> Bool = {
			if $0 == "." || charToDouble($0) >= 0 {
				return true
			} else {
				return false
			}
		}

		let wktChars = Array(wkt.characters)

		let findNumber: ([Character], Int) -> (number: Double, end: Int) = { source, begin in

			var number: Double = 0

			var start = begin
			while start < source.count {
				guard isDigitOrMinus(source[start]) else {
					number *= 10
					number += charToDouble(source[start])
					start = start.successor()
					continue
				}
				break
			}

			var decimalMultiplier = 0.1

			var end = start.successor()
			while end < source.count {
				guard isDigitOrDot(source[end]) else { break }
				number += decimalMultiplier * charToDouble(source[end])
				decimalMultiplier /= 10
				end = end.successor()
			}

			return (number: number, end: end)
		}

		var baseMinMax:
			(min: (lon: Double, lat: Double), max: (lon: Double, lat: Double)) =
			(min: (lon: 180, lat: 180), max: (lon: -180, lat: -180))

		var start = 0

		while start < wktChars.count {

			let longitudeTuple = findNumber(wktChars, start)
			let longitude = longitudeTuple.number

			start = longitudeTuple.end

			let latitudeTuple = findNumber(wktChars, start)
			let latitude = latitudeTuple.number

			start = latitudeTuple.end

			let mins = baseMinMax.min
			let maxs = baseMinMax.max

			baseMinMax = (
				min: (min(mins.lon, longitude), min(mins.lat, latitude)),
				max: (max(maxs.lon, longitude), max(maxs.lat, latitude))
			)

		}

		return baseMinMax

	}

	/**
	 Returns minimum and maximum longitude and latitude of polygons in given
	 WKT geometry.

	 # Motivation

	 Initially retrieving minimum and maximum longitude and latitude was
	 performed using a regular expression. However this approach required a lot
	 of memory for both: pattern creation and matching as pattern matching
	 engine doesn't scale well with complex patterns.

	 This method uses a simpler pattern that requires a lot less memory and it's
	 faster than loop-based implementation but it's slower than the complex
	 regex-based one.

	 - note: Uses regex in its implementation.

	 - parameter wkt: Geometry to analyze.

	 - throws: Error when given geometry is not a valid WKT geometry.

	 - returns: Minimum and maximum longitude and latitude.
	 */
	private static func minimumAndMaximumLongitudeAndLatitudeInWKTGeometry_splitted_regex_implementation(wkt: String) throws ->
	(min: (lon: Double, lat: Double), max: (lon: Double, lat: Double)) {

		// (-?\d+(?:\.\d+)?)
		let allDecimalNumbers = "(-?\\d+(?:\\.\\d+)?)"

		let matches = try wkt.matchesForRegex(allDecimalNumbers)

		var baseMinMax:
			(min: (lon: Double, lat: Double), max: (lon: Double, lat: Double)) =
			(min: (lon: 180, lat: 180), max: (lon: -180, lat: -180))

		var index = matches.startIndex
		while index < matches.endIndex {

			guard let longitude = Double(matches[index]),
				let latitude = Double(matches[index.advancedBy(2)]) else {
					throw NSError(
						domain: "GeometryUtilities.minimumAndMaximumLongitudeAndLatitudeInWKTGeometry_splitted_regex_implementation",
						code: -1,
						userInfo: ["wkt": wkt]
					)
			}
			index = index.advancedBy(4)

			let mins = baseMinMax.min
			let maxs = baseMinMax.max

			baseMinMax = (
				min: (min(mins.lon, longitude), min(mins.lat, latitude)),
				max: (max(maxs.lon, longitude), max(maxs.lat, latitude))
			)

		}

		return baseMinMax

	}

	/**
	 Returns minimum and maximum longitude and latitude of polygons in given
	 WKT geometry.

	 - note: Uses regex in its implementation.

	 - parameter wkt: Geometry to analyze.

	 - throws: Error when given geometry is not a valid WKT geometry.

	 - returns: Minimum and maximum longitude and latitude.
	 */
	private static func minimumAndMaximumLongitudeAndLatitudeInWKTGeometry_regex_implementation(wkt: String) throws ->
	(min: (lon: Double, lat: Double), max: (lon: Double, lat: Double)) {

		// (-?\d+(?:\.\d+)?\s-?\d+(?:\.\d+)?)
		let latitudeAndLongitudeRegex = "(-?\\d+(?:\\.\\d+)?\\s-?\\d+(?:\\.\\d+)?)"

		let matches = try wkt.matchesForRegex(latitudeAndLongitudeRegex)

		let baseMinMax:
			(min: (lon: Double, lat: Double), max: (lon: Double, lat: Double)) =
			(min: (lon: 180, lat: 180), max: (lon: -180, lat: -180))

		return matches.flatMap { match -> (lat: Double, lon: Double)? in
			guard let m = try? match.matchesForRegex("(.*) (.*)"),
				let longitude = Double(m[1]),
				let latitude = Double(m[2])
			else { return nil }
			return (lon: longitude, lat: latitude)
		}.reduce(baseMinMax) { reduced, pair in
			let mins = reduced.min
			let maxs = reduced.max
			return (
				min: (min(mins.lon, pair.lon), min(mins.lat, pair.lat)),
				max: (max(maxs.lon, pair.lon), max(maxs.lat, pair.lat))
			)
		}

	}

	// TODO: Implement with split

	/**
	 Returns minimum and maximum longitude and latitude of polygons in given
	 WKT geometry.

	 - note: Uses split in its implementation.

	 - parameter wkt: Geometry to analyze.

	 - throws: Error when given geometry is not a valid WKT geometry.

	 - returns: Minimum and maximum longitude and latitude.
	 */
	private static func minimumAndMaximumLongitudeAndLatitudeInWKTGeometry_splitted_implementation(wkt: String) throws ->
	(min: (lon: Double, lat: Double), max: (lon: Double, lat: Double)) {

		var baseMinMax:
			(min: (lon: Double, lat: Double), max: (lon: Double, lat: Double)) =
			(min: (lon: 180, lat: 180), max: (lon: -180, lat: -180))

		let polygons = wkt.stringByRemoving(["MULTIPOLYGON(((", ")))"]).componentsSeparatedByString(")),((")

		for polygon in polygons {

			let points = polygon.componentsSeparatedByString(",")

			for point in points {

				let pair = point.componentsSeparatedByString(" ")

				guard let longitude = Double(pair[0]), latitude = Double(pair[1]) else { continue }

				let mins = baseMinMax.min
				let maxs = baseMinMax.max

				baseMinMax = (
					min: (min(mins.lon, longitude), min(mins.lat, latitude)),
					max: (max(maxs.lon, longitude), max(maxs.lat, latitude))
				)

			}

		}

		if baseMinMax.min.lon == 180 {
			throw NSError(
				domain: "GeometryUtilities.minimumAndMaximumLongitudeAndLatitudeInWKTGeometry_splitted_implementation",
				code: -1,
				userInfo: ["wkt": wkt]
			)
		}

		return baseMinMax

	}

}