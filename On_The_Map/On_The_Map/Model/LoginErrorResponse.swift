//
//  LoginErrorResponse.swift
//  On_The_Map
//
//  Created by Shailaja on 27/01/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation

struct LoginErrorResponse: Decodable{
    
    let status: Int
    let error: String
    
    var output: String{
        get {status == 400 ? "Please enter your email and password" : error}
    }
    
}
