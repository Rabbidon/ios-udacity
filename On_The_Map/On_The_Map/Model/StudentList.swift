//
//  StudentList.swift
//  On_The_Map
//
//  Created by Shailaja on 27/01/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation

struct StudentList: Codable{
    var results = [StudentInformation]()
}

struct StudentInformation:Codable{
    let createdAt: String
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    let objectId: String
    let uniqueKey: String
    let updatedAt: String
}
