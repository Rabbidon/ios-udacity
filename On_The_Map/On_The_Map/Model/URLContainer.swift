//
//  URLContainer.swift
//  On_The_Map
//
//  Created by Shailaja on 25/01/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation


struct URLContainer{
    static let udacityBase = "https://onthemap-api.udacity.com"
    
    static let sessionEndpoint = "/v1/session"
    static let locationEndpoint = "/v1/StudentLocation"
    
    static let sessionFull = udacityBase+sessionEndpoint
    static let locationFull = udacityBase+locationEndpoint
}
