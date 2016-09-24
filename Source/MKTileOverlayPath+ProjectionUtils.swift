//
//  MKTileOverlayPath+ProjectionUtils.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun on 5/7/16.
//  Copyright © 2016 VisualNACert. All rights reserved.
//

import MapKit

extension MKTileOverlayPath {

	// Utils from: https://github.com/Sumbera/WMSOnMapKit-iOS7

    #if swift(>=3)
	fileprivate func bboxWGS84XOf(column: Int, zoom: Int) -> Double {
		return Double(column) / pow(2.0, Double(zoom)) * 360.0 - 180
	}

	fileprivate func bboxWGS84YOf(row: Int, zoom: Int) -> Double {
		let n = M_PI - 2.0 * M_PI * Double(row) / pow(2.0, Double(zoom))
		return 180.0 / M_PI * atan(0.5 * (exp(n) - exp(-n)));
	}

	fileprivate func mercatorXOf(longitude: Double) -> Double {
		return longitude * 20037508.34 / 180;
	}

	fileprivate func mercatorYOf(latitude: Double) -> Double {
		return log(tan((90 + latitude) * M_PI / 360)) / (M_PI / 180) * 20037508.34 / 180;
	}

	fileprivate var bboxWGS84Components: (Double, Double, Double, Double) {
		get {
			let left = bboxWGS84XOf(column: self.x, zoom: self.z); // minX
			let right = bboxWGS84XOf(column: self.x + 1, zoom: self.z); // maxX
			let bottom = bboxWGS84YOf(row: self.y + 1, zoom: self.z); // minY
			let top = bboxWGS84YOf(row: self.y, zoom: self.z); // maxY
			return (left, right, bottom, top)
		}
	}
    #else
    private func bboxWGS84XOf(column column: Int, zoom: Int) -> Double {
        return Double(column) / pow(2.0, Double(zoom)) * 360.0 - 180
    }
    
    private func bboxWGS84YOf(row row: Int, zoom: Int) -> Double {
        let n = M_PI - 2.0 * M_PI * Double(row) / pow(2.0, Double(zoom))
        return 180.0 / M_PI * atan(0.5 * (exp(n) - exp(-n)));
    }
    
    private func mercatorXOf(longitude longitude: Double) -> Double {
        return longitude * 20037508.34 / 180;
    }
    
    private func mercatorYOf(latitude latitude: Double) -> Double {
        return log(tan((90 + latitude) * M_PI / 360)) / (M_PI / 180) * 20037508.34 / 180;
    }
    
    private var bboxWGS84Components: (Double, Double, Double, Double) {
        get {
            let left = bboxWGS84XOf(column: self.x, zoom: self.z); // minX
            let right = bboxWGS84XOf(column: self.x + 1, zoom: self.z); // maxX
            let bottom = bboxWGS84YOf(row: self.y + 1, zoom: self.z); // minY
            let top = bboxWGS84YOf(row: self.y, zoom: self.z); // maxY
            return (left, right, bottom, top)
        }
    }
    #endif

	public var bboxWGS84: String {
		get {
			let (left, right, bottom, top) = self.bboxWGS84Components
			return "\(left),\(bottom),\(right),\(top)"
		}
	}

    #if swift(>=3)
	fileprivate var bboxMercatorComponents: (Double, Double, Double, Double) {
		get {
			let (left, right, bottom, top) = self.bboxWGS84Components
			return (
				self.mercatorXOf(longitude: left),
				self.mercatorXOf(longitude: right),
				self.mercatorYOf(latitude: bottom),
				self.mercatorYOf(latitude: top)
			)
		}
	}
    #else
    private var bboxMercatorComponents: (Double, Double, Double, Double) {
        get {
            let (left, right, bottom, top) = self.bboxWGS84Components
            return (
                self.mercatorXOf(longitude: left),
                self.mercatorXOf(longitude: right),
                self.mercatorYOf(latitude: bottom),
                self.mercatorYOf(latitude: top)
            )
        }
    }
    #endif

	public var bboxMercator: String {
		get {
			let (left, right, bottom, top) = self.bboxMercatorComponents
			return "\(left),\(bottom),\(right),\(top)"
		}
	}

}
