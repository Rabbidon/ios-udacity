//
//  ResultViewController.swift
//  Roshando
//
//  Created by Shailaja on 13/01/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var labelText = ""
    var imageIdentifier = ""
    
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Label.text = labelText
        Label.sizeToFit()
        Image.image = UIImage(named:imageIdentifier)
    }
    
    @IBAction func dismiss() {
    // dismiss this view controller
    self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
