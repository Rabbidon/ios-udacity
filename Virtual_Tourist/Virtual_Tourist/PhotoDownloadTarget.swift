//
//  PhotoDownloadTarget.swift
//  Virtual_Tourist
//
//  Created by Shailaja on 11/02/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation

struct PhotoDownloadTarget:Codable{
    var photos: PhotoDataContainer
}

struct PhotoDataContainer:Codable{
    var total: String
    var photo: [PhotoData]
}

struct PhotoData:Codable{
    
    var farm: Int
    var server: String
    var id: String
    var secret: String
    
    var urlData:Data?{
        get{
            return try? Data(contentsOf: URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg)")!)
        }
    }
    
}
