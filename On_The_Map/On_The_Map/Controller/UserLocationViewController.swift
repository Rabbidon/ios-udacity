//
//  UserLocationViewController.swift
//  On_The_Map
//
//  Created by Shailaja on 01/02/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class UserLocationViewController: UIViewController, MKMapViewDelegate{
    
    override func viewDidLoad() {
        map.delegate = self
        let annotation = MKPointAnnotation()
        annotation.coordinate = myCoordinates!
        map.setCenter(myCoordinates!, animated: false)
        map.addAnnotation(annotation)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func postLocation(_ sender: Any) {
    
        APICalls.postUserLocation(location :myLocation,url:myLink,currentController:self)
    }
    
    var myLocation = String()
    
    var myLink = String()
    
    var myCoordinates: CLLocationCoordinate2D? = nil
    
    @IBOutlet weak var map: MKMapView!
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        return pin
    }
    
}
