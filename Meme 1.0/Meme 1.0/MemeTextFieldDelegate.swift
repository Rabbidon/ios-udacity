//
//  MemeTextFieldDelegate.swift
//  Meme 1.0
//
//  Created by Shailaja on 15/01/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import UIKit

// TestFieldDelegate for our meme text

class MemeTextFieldDelegate: NSObject,UITextFieldDelegate{
    
    // One-time flag that erases filler text when field is accessed
    var hasBeenTouched = false
    
    // Code the erases filler and flips one-time flag
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !hasBeenTouched{
            textField.text = ""
        }
        hasBeenTouched = true
    }
    
    // Allows user to exit by hitting return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
}
