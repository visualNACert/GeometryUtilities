//
//  MKPolygon+Coordinates.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun on 31/10/16.
//

import MapKit

extension MKPolygon {

	/// Returns coordinates of points of this polygon.
	public func coordinates() -> [CLLocationCoordinate2D] {
		var coords = [CLLocationCoordinate2D](
            repeating: .zero,
            count: self.pointCount
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

	/**
     Returns whether point at given coordinates is contained in this polygon
     or not.
     
     - parameter coordinates: Coordinates of point to be checked.
     
     - returns: `true` if point is contained in this polygon.
     */
	public func contains(
		pointAt coordinates: CLLocationCoordinate2D
	) -> Bool {

		let polygonRenderer = MKPolygonRenderer(polygon: self)
		let currentMapPoint = MKMapPointForCoordinate(coordinates)
		let polygonViewPoint = polygonRenderer.point(for: currentMapPoint)

        return polygonRenderer.path.contains(polygonViewPoint)

	}

	/* Possible alternative solution that should be considered...
	 // - note: Taken from: http://alienryderflex.com/polygon/
	 public func contains(
	 pointAtCoordinates coordinates: CLLocationCoordinate2D
	 ) -> Bool {

	 let corners = self.coordinates()

	 let x = coordinates.longitude
	 let y = coordinates.latitude

	 let polyX = corners.map { $0.longitude }
	 let polyY = corners.map { $0.latitude }

	 var i = 0
	 var j = corners.count - 1
	 var oddNodes = false

	 while i < corners.count {

	 // If clause prevents division by zero...
	 if (
	 (polyY[i] < y && polyY[j] >= y || polyY[j] < y && polyY[i] >= y) &&
	 (polyX[i] <= x || polyX[j] <= x)
	 ) {
	 oddNodes ^= (
	 polyX[i] +
	 (y - polyY[i]) / (polyY[j] - polyY[i]) * (polyX[j] - polyX[i])
	 < x
	 )
	 }

	 j = i
	 i++

	 }

	 return oddNodes

	 }
	 */

}
