//
//  ImageDownloadHelper.swift
//  Virtual_Tourist
//
//  Created by Shailaja on 13/02/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloadHelper{
    
    static func downloadPhoto(_ cell: AlbumViewController.CustomCollectionCell, _ indexPath: IndexPath, _ vc:AlbumViewController)->AlbumViewController.CustomCollectionCell{
        if let photo = vc.photos[(indexPath as NSIndexPath).item]{
            cell.image.image = UIImage(data: photo.image!)
        }
        else{
            cell.image.image = UIImage(named: "placeholder")
            DispatchQueue.global().async { () in
                if let data = vc.photoSource[(indexPath as NSIndexPath).item].urlData {
                    let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            let photo = Photo(context: AppDelegate.dataController.viewContext)
                            photo.ownedBy = vc.pin!
                            photo.image = image?.jpegData(compressionQuality: 1.0)
                            try? AppDelegate.dataController.viewContext.save()
                            vc.photos[(indexPath as NSIndexPath).item] = photo
                            cell.image.image = image
                    }
                }
            }
        }
        return cell
    }
    
}
