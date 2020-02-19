//
//  ViewController.swift
//  Meme 1.0
//
//  Created by Shailaja on 13/01/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import UIKit

class CreateMemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Initialise objects

    @IBOutlet weak var navbar: UINavigationBar!
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    let topTextFieldDelegate = MemeTextFieldDelegate()
    let bottomTextFieldDelegate = MemeTextFieldDelegate()
    let backButton = UIBarButtonItem(
          title: "Cancel",
          style: UIBarButtonItem.Style.plain,
          target: nil,
          action: nil
    );
    
    // Setup methods
    
    override func viewDidLoad() {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        super.viewDidLoad()
        formatTextField(field:topTextField,delegate:topTextFieldDelegate)
        formatTextField(field:bottomTextField,delegate:bottomTextFieldDelegate)
        shareButton.isEnabled = false
        
        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backButton
    }
    
    // Method called to format the top and bottom text fields for use as meme text field
    
    func formatTextField (field f:UITextField, delegate d:UITextFieldDelegate){
        f.delegate = d
        f.defaultTextAttributes = memeTextAttributes
        f.textAlignment = .center
    }
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // Specify attributes for our font
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -3.0
        
    ]
    
    // Image picker helper method
    
    func pickImage(_ sender: Any, type t: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Image picker methods

    @IBAction func pickImageFromAlbum(_ sender: Any) {
        pickImage(sender, type: .photoLibrary)
    }
    
    @IBAction func pickImageFromCamera(_ sender: Any) {
        pickImage(sender, type: .camera)
    }
    
    // Methods to handle user input from the Image Picker
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
        dismiss(animated: true, completion: nil)
        shareButton.isEnabled = true
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePickerView.image = nil
        dismiss(animated: true, completion: nil)
        shareButton.isEnabled = false
    }
    
    // Gets the height of the user's keyboard
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {

           let userInfo = notification.userInfo
           let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
           return keyboardSize.cgRectValue.height
       }
    
    // Changes the frame height if bottom text field is first responder while switching in/out of it.
    // This has the effect of allowing the user to see what they are typing into the bottom text field
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isFirstResponder
        {
            view.frame.origin.y = (-1)*getKeyboardHeight(notification)
            }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if bottomTextField.isFirstResponder
        {
            view.frame.origin.y = 0
            }
    }
    
    // Handles the Notification Center
    
    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Generates the memed image
    
    func generateMemedImage() -> UIImage {

        navbar.isHidden = true
        toolbar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
    navbar.isHidden = false
    toolbar.isHidden = false

        return memedImage
    }
    
    // Meme struct that saves the altered image, along with the original and the contents of both text fields
    
    // Generates a meme, in the full struct format described above
    
    func save() {
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memeArray.append(meme)
    }
    
    // Saves the memed image to your photos (as well as the full meme in memory))
    
    @IBAction func share(_ sender: Any) {
        let memedImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        controller.completionWithItemsHandler = { activity, success, items, error in
            self.save()
            self.dismiss(animated: true, completion: nil)
        }
        
        present(controller, animated: true, completion: nil)
    }
}


