//
//  ViewController.swift
//  On_The_Map
//
//  Created by Shailaja on 23/01/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func pressLogin(_ sender: Any) {
        APICalls.udacityPostSession(currentController: self, usernameTextField: emailField, passwordTextField: passwordField)
    }
    
    @IBAction func signUp(_ sender: Any) {
        if let url = URL(string: "https://auth.udacity.com/sign-up") {
            UIApplication.shared.open(url)
        }
    }
    
}

