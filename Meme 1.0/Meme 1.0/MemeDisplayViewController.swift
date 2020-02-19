//
//  MemeDisplayViewController.swift
//  Meme 1.0
//
//  Created by Shailaja on 18/01/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import UIKit
import Foundation

class MemeDisplayViewController: UIViewController{
    
    var displayedMeme: Meme? = nil
    
    @IBOutlet weak var displayView: UIImageView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        displayView.image = displayedMeme!.memedImage
    }
    
}
