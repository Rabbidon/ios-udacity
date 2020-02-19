//
//  CustomMapViewController.swift
//  On_The_Map
//
//  Created by Shailaja on 30/01/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class CustomMapViewController: UIViewController, MKMapViewDelegate, CustomTabChild, ClickableCalloutAnnotationViewDelegate{
    
    func didTapCallout(for annotation: MKAnnotation) {
        let alert = UIAlertController(title: "Invalid URL", message: "The URL you are trying to access is invalid", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("Map Invalid URL Access Alert Occurred")
        }))
       if let url =  URL(string:(annotation.subtitle!)!)
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
    
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        map.delegate = self
    }
    
    func update(){
        populateMap()
    }
    
    func populateMap(){
        map.removeAnnotations(map.annotations)
        var annotationList = [MKPointAnnotation]()
        for info in Global.studentList{
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: info.latitude, longitude: info.longitude)
            annotation.title = info.firstName+" "+info.lastName
            annotation.subtitle = info.mediaURL
            annotationList.append(annotation)
        }
        map.addAnnotations(annotationList)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: ClickableCalloutAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier:ClickableCalloutAnnotationView.preferredReuseIdentifier){
            annotationView = dequeuedAnnotationView as? ClickableCalloutAnnotationView
            annotationView?.annotation = annotation
        }
        else{
            annotationView = ClickableCalloutAnnotationView(annotation: annotation, reuseIdentifier: ClickableCalloutAnnotationView.preferredReuseIdentifier)
        }
        annotationView?.delegate = self
        return annotationView

    }
    
}
