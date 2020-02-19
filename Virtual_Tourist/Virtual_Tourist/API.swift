//
//  APIKey.swift
//  Virtual_Tourist
//
//  Created by Shailaja on 11/02/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import MapKit
import CoreData

class API{
    
    static let key = "e9141eca53b226695c73db4fcdd3ad61"
    
    static let endpoint = "https://api.flickr.com/services/rest"
    
    static func downloadPhotos(pin p: Pin, viewController vc: AlbumViewController, dataContext: NSManagedObjectContext){
        vc.gettingUrls.startAnimating()
        let request = URLRequest(url:URL(string: endpoint+"/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=\(key)&page=\(Int.random(in:1...4))&lat=\(p.latitude)+&lon=\(p.longitude)")!)
        let session=URLSession.shared
        let task = session.dataTask(with: request){
            data,response,error in
            if error != nil {
              DispatchQueue.main.async{
                let alert = UIAlertController(title: "Image Download Failed", message: error?.localizedDescription, preferredStyle: .alert)
                  
                  alert.modalPresentationStyle = .overCurrentContext
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                        NSLog("Image download failure alert occurred")
                        }))
                                                  vc.present(alert, animated: true, completion: nil)}
            }
            else{
                let decoder = JSONDecoder()
                let photoDownloadTarget = try! decoder.decode(PhotoDownloadTarget.self, from:data!)
                vc.photoSource = photoDownloadTarget.photos.photo
                
                vc.photos = [Photo?](repeating: nil, count: vc.photoSource.count)
                DispatchQueue.main.async{vc.gettingUrls.stopAnimating();
                    vc.collectionView.reloadData()
                }
            }
        }
            task.resume()
        
    }

}
