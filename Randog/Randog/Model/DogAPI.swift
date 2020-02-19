//
//  DogAPI.swift
//  Randog
//
//  Created by Shailaja on 20/01/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation

class DogAPI{
    enum Endpoint: String{
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        
        var url:URL{
            return URL(string:self.rawValue)!
        }
    }
}
