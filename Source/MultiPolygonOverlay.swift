//
//  MultiPolygonOverlay.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun on 20/7/16.
//  Copyright © 2016 VisualNACert. All rights reserved.
//

import MapKit

@objc public protocol MultiPolygonOverlay: MKOverlay {

	/// Polygons in this overlay.
	var polygons: [MKPolygon] { get }

	/// Amount of points required to draw complex shape.
	var complexShapePointCount: Int { get }

	/// Simplified polygon for this overlay.
	var simplifiedPolygon: MKPolygon { get }

	/// Amount of points required to draw simplified shape.
	var simplifiedShapePointCount: Int { get }

	/// Unique identifier of this multi polygon overlay.
	var uniqueIdentifier: String { get }

	/// Whether this polygon is selected and should be drawn as selected or not.
	var selected: Bool { get set }

}
