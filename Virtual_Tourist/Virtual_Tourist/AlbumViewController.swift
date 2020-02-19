//
//  AlbumViewController.swift
//  Virtual_Tourist
//
//  Created by Shailaja on 10/02/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import UIKit

class AlbumViewController: UICollectionViewController,
UICollectionViewDelegateFlowLayout{
    
    var pin: Pin? = nil
    
    var photoSource: [PhotoData] = []
    
    var photos: [Photo?] = []
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var gettingUrls: UIActivityIndicatorView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width-(2*space))/3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        if let coreDataPhotoSet = pin!.owns{
            if coreDataPhotoSet.count == 0{
                API.downloadPhotos(pin: pin!, viewController: self, dataContext: AppDelegate.dataController.viewContext)
            }
            photos = coreDataPhotoSet.map{$0 as! Photo}
            collectionView.reloadData()
        }
        else{
            API.downloadPhotos(pin: pin!, viewController: self, dataContext: AppDelegate.dataController.viewContext)
        }
        
    }
    
    @IBAction func replaceImages(_ sender: Any) {
        pin!.owns = nil
        API.downloadPhotos(pin: pin!, viewController: self, dataContext: AppDelegate.dataController.viewContext)
        self.collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    @objc(PhotoCell) class CustomCollectionCell:
    UICollectionViewCell{
        @IBOutlet weak var image: UIImageView!
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> CustomCollectionCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! CustomCollectionCell
        return ImageDownloadHelper.downloadPhoto(cell,indexPath,self)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let photo = photos[(indexPath as NSIndexPath).item]{
            photos.remove(at: (indexPath as NSIndexPath).item)
        AppDelegate.dataController.viewContext.delete(photo)
            try? AppDelegate.dataController.viewContext.save()
            collectionView.reloadData()
        }
            
    }
    
    
// Need to work out how to pull from the API
    
}
