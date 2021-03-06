//
//  CLLocationCoordinate2D+Mercator.swift
//  GeometryUtilities
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 1/11/16.
//

import MapKit

extension CLLocationCoordinate2D {

    /// Mercator X component of this coordinate.
    var mercatorX: Double {
        return self.longitude * 20037508.34 / 180;
    }

    /// Mercator Y component of this coordinate.
    var mercatorY: Double {
        return log(
            tan((90 + latitude) * .pi / 360)
        ) / (.pi / 180) * 20037508.34 / 180;
    }

}
