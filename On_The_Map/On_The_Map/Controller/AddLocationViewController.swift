//
//  AddLocationViewController.swift
//  On_The_Map
//
//  Created by Shailaja on 31/01/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation

class AddLocationViewController: UIViewController{
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    var placemark: CLPlacemark? = nil
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! UserLocationViewController
        destination.myCoordinates = placemark!.location!.coordinate
        destination.myLink = urlField.text ?? ""
        destination.myLocation = locationField.text ?? ""
    }

    @IBOutlet weak var actInd: UIActivityIndicatorView!
    
    @IBOutlet weak var locationField: UITextField!
    
    @IBOutlet weak var urlField: UITextField!
    
    @IBAction func findLocation(_ sender: Any) {
        APICalls.geolocate(locationField: locationField, urlField: urlField, actInd: actInd, currentController: self)
    }
    
    
}
