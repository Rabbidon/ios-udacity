//
//  CustomTabViewController.swift
//  On_The_Map
//
//  Created by Shailaja on 30/01/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import UIKit

protocol CustomTabChild{
    func update()
}

class CustomTabViewController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.logout(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        downloadStudentInformation()
    }
    
    @objc func logout(sender: UIBarButtonItem) {
        APICalls.udacityDeleteSession(currentController: self)
    }
    
    func downloadStudentInformation(){
        APICalls.obtainStudentInformation(currentController: self)
    }
    
    @IBAction func refresh(_ sender: Any) {
        downloadStudentInformation()
    }
    
    func updateChildren(){
        for vc in self.children{
            (vc as! CustomTabChild).update()
        }
    }
    
    

}


