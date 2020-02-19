//
//  Pin+Extra.swift
//  Virtual_Tourist
//
//  Created by Shailaja on 09/02/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import MapKit

extension Pin: MKAnnotation{
    
    public var coordinate: CLLocationCoordinate2D {
        get{
            return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        }
    }
    
}
