//
//  LoginResponse.swift
//  On_The_Map
//
//  Created by Shailaja on 26/01/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation

struct LoginResponse: Codable{
    
    let account: AccountHeader
    let session: SessionHeader
    
}

struct AccountHeader: Codable{
    
    let registered: Bool
    let key: String
    
}

struct SessionHeader: Codable{
    
    let id: String
    let expiration: String
    
}
