//
//  APICalls.swift
//  On_The_Map
//
//  Created by Shailaja on 31/01/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class APICalls{
    
    static func udacityPostSession(currentController vc:UIViewController, usernameTextField u:UITextField, passwordTextField p:UITextField){
        var request = URLRequest(url: URL(string: URLContainer.sessionFull)!)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(u.text!)\", \"password\": \"\(p.text!)\"}}".data(using: .utf8)
                let session = URLSession.shared
                let task = session.dataTask(with: request) { data, response, error in
                    guard error == nil else { DispatchQueue.main.async{
        let alert = UIAlertController(title: "Failed to Connect", message: error!.localizedDescription, preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                  NSLog("Login Connection Failure Alert Occurred")
                  }))
                                            vc.present(alert, animated: true, completion: nil)}
                      return
                  }
                  let range = 5..<data!.count
                  let newData = data?.subdata(in: range)
                  let decoder = JSONDecoder()
                    do{
                        let successLoginResponse = try decoder.decode(LoginResponse.self, from: newData!)
                       
                        let request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/users/\(successLoginResponse.account.key)")!)
                       let session = URLSession.shared
                       let task = session.dataTask(with: request) { data, response, error in
                         if error != nil {
                             return
                         }
                         let range = 5..<data!.count
                         let newData = data?.subdata(in: range)
                        
                        let decoder = JSONDecoder()
                        
                        Global.userInfo = try! decoder.decode(UserInfo.self,from:newData!)
                     DispatchQueue.main.async{vc.performSegue(withIdentifier: "successfulLoginSegue", sender: nil)}
                       }
                       task.resume()
                    }
                    catch
                    {let failedLoginResponse = try! decoder.decode(LoginErrorResponse.self, from: newData!)
                        DispatchQueue.main.async{
                        let alert = UIAlertController(title: "Invalid Login", message: failedLoginResponse.output, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("Invalid Login Alert Occurred")
                    }))
                          
                              vc.present(alert, animated: true, completion: nil)}
                    }
                }
                task.resume()
    }
    
    static func udacityDeleteSession(currentController vc:UIViewController){
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
          if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
          request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil {
            DispatchQueue.main.async{
            let alert = UIAlertController(title: "Failed to Logout", message: "Please try again - maybe check your internet", preferredStyle: .alert)
                      alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                      NSLog("Logout Failure Alert Occurred")
                      }))
                                                vc.present(alert, animated: true, completion: nil)}
              return
          }
          let range = 5..<data!.count
          let newData = data?.subdata(in: range) /* subset response data! */
            print(String(data: newData!, encoding: .utf8)!)
            DispatchQueue.main.async{_ = vc.navigationController?.popViewController(animated: true)}
            Global.userInfo = nil
        }
        task.resume()
    }
    
    static func obtainStudentInformation(currentController vc:CustomTabViewController){
        let request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation?order=-updatedAt&limit=100")!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
          if error != nil {
            DispatchQueue.main.async{
            let alert = UIAlertController(title: "Failure to Download Student Data", message: "Required data could not be downloaded. The Map and Table views have not been updated", preferredStyle: .alert)
                
                alert.modalPresentationStyle = .overCurrentContext
                      alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                      NSLog("Student Data Download Alert Occurred")
                      }))
                                                vc.present(alert, animated: true, completion: nil)}
          }
          else{
            let decoder = JSONDecoder()
            Global.studentList = (try! decoder.decode(StudentList.self,from:data!)).results
            DispatchQueue.main.async{vc.updateChildren()}
            }
        }
        task.resume()
    }
    
    static func geolocate(locationField l:UITextField, urlField u:UITextField, actInd ai: UIActivityIndicatorView, currentController vc:AddLocationViewController){
        ai.startAnimating()
        let alert = UIAlertController(title: "Geocoding Failed", message: "Could not find location", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("Geolocation Failure Alert Occurred")
        }))
        let geo = CLGeocoder()
        geo.geocodeAddressString(l.text!) {
            (placemarks, error) -> Void in
            defer {
                DispatchQueue.main.async{ai.stopAnimating()
                }
            }
            if((error) != nil){
               DispatchQueue.main.async{
                                                   vc.present(alert, animated: true, completion: nil)}
            }
            else{
                vc.placemark = placemarks!.first
                DispatchQueue.main.async{
                    vc.performSegue(withIdentifier: "showLocationOnMap", sender: nil)}
            }
        }
    }
    
    static func postUserLocation(location l:String, url u:String, currentController vc:UserLocationViewController)
    {

        let coordinates:CLLocationCoordinate2D = vc.myCoordinates!
            var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation")!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = "{\"uniqueKey\": \"\(Global.userInfo!.key)\", \"firstName\": \"\(Global.userInfo!.first_name)\", \"lastName\": \"\(Global.userInfo!.last_name)\",\"mapString\": \"\(l)\", \"mediaURL\": \"\(u)\",\"latitude\": \(coordinates.latitude), \"longitude\": \(coordinates.longitude)}".data(using: .utf8)
                let session = URLSession.shared
                let task = session.dataTask(with: request) { data, response, error in
                  if error != nil {
                      DispatchQueue.main.async{
                      let alert = UIAlertController(title: "Failure to Post Location", message: "Location Data was not posted successfullly", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                                NSLog("Post Failure Alert Occurred")
                                }))
                        vc.present(alert, animated: true, completion: nil)}
                    return
                  }
                  else{
                    DispatchQueue.main.async{vc.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: nil)}
                    }
                }
                task.resume()
           }
    
}
