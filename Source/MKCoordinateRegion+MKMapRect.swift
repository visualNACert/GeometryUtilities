//
//  MKCoordinateRegion+MKMapRect.swift
//  Pods
//
//  Created by Lluís Ulzurrun de Asanza Sàez on 25/11/16.
//
//

import MapKit

extension MKCoordinateRegion {
    
    /// Map rect equivalent to this coordinate region.
    public var mapRect: MKMapRect {
            
        let origin = CLLocationCoordinate2D(
            latitude: self.center.latitude - self.span.latitudeDelta / 2.0,
            longitude: self.center.longitude - self.span.longitudeDelta / 2.0
        )
        
        let end = CLLocationCoordinate2D(
            latitude: self.center.latitude + self.span.latitudeDelta / 2.0,
            longitude: self.center.longitude + self.span.longitudeDelta / 2.0
        )
        
        let originPoint = MKMapPointForCoordinate(origin)
        let endPoint = MKMapPointForCoordinate(end)
        
        return MKMapRectMake(
            originPoint.x,
            originPoint.y,
            endPoint.x - originPoint.x,
            endPoint.y - originPoint.y
        )
    
    }
    
}
