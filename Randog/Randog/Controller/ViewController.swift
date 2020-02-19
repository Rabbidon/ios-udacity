//
//  ViewController.swift
//  Randog
//
//  Created by Shailaja on 20/01/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var searchURL:URL? = nil
    
    override func viewDidLoad() {
        generateImage()
    }
    
    func generateImage(){
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchURL = DogAPI.Endpoint.randomImageFromAllDogsCollection.url
        let task =
        URLSession.shared.dataTask(with: searchURL!){
            (data,response,error) in
            guard let data = data else {return}
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self,from: data)
            let message = imageData.message
            guard let imageURL = URL.init(string: message) else {return}
            let task =
                URLSession.shared.dataTask(with: imageURL){(data,response,error) in
                    guard let data = data else {return}
                    let myImage = UIImage(data: data)
                    DispatchQueue.main.async{self.dogView.image = myImage}
            }
        task.resume()
        }
        task.resume()
}

    @IBOutlet weak var dogView: UIImageView!
    
    @IBAction func getDog(_ sender: Any) {
        generateImage()
    }
    
}

