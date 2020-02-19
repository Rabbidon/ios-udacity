//
//  MemeTableViewController.swift
//  Meme 1.0
//
//  Created by Shailaja on 17/01/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import UIKit
import Foundation

class MemeCollectionViewController: UICollectionViewController{
    
    var chosenMeme: Meme? = nil
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memeArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width-(2*space))/3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    @objc(DCell) class CustomCollectionCell:
    UICollectionViewCell{
        @IBOutlet weak var memeImage: UIImageView!
    }
    
    @objc func addButtonClicked(){
        performSegue(withIdentifier: "fromCollectionToEditor", sender: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> CustomCollectionCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCell2", for: indexPath) as! CustomCollectionCell
        let meme = memes[(indexPath as NSIndexPath).item]

        cell.memeImage.image = meme.originalImage

        return cell
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromCollectionToDisplay" {
            let vc = segue.destination as! MemeDisplayViewController
            vc.displayedMeme = chosenMeme
        }
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        chosenMeme = memes[indexPath.item]
        performSegue(withIdentifier: "fromCollectionToDisplay", sender: nil)
    }

}
