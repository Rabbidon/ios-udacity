//
//  CustomTableViewController.swift
//  On_The_Map
//
//  Created by Shailaja on 30/01/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import UIKit

class CustomTableViewController: UITableViewController, CustomTabChild{
    
    func update() {
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return Global.studentList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "StudentInfoCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let info = Global.studentList[indexPath.row]
        
        cell.textLabel!.text = info.firstName+" "+info.lastName
        cell.detailTextLabel!.text = info.mediaURL
        cell.imageView?.image = UIImage(named: "icon_pin")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Invalid URL", message: "The URL you are trying to access is invalid", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("Table Invalid URL Access Alert Occurred")
        }))
        if let url =  URL(string:Global.studentList[indexPath.row].mediaURL)
        {
            UIApplication.shared.open(url){
                (success) in
                if !success{
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        else{
            
                                    self.present(alert, animated: true, completion: nil)
        }
    }
}
