//
//  MemeTableViewController.swift
//  Meme 1.0
//
//  Created by Shailaja on 17/01/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import UIKit
import Foundation

class MemeTableViewController: UITableViewController{
    
    // Accessor for the AppDelegate
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // Calculated meme array property
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memeArray
    }
    
    // Passed to the meme viewer when the user selects a meme to view
    
    var chosenMeme: Meme? = nil
    
    // Initialisation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
    }
    
    // Reloads data whenever this becomes the primary view
    
    override func viewWillAppear(_ animated:Bool){
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    // Defines the custom cell type
    
    @objc(CCell) class CustomTableCell:
    UITableViewCell{
        @IBOutlet weak var memeDescription: UILabel!
        @IBOutlet weak var memeImage: UIImageView!
        
    }
    
    // Goes to thememe editor
    
    @objc func addButtonClicked(){
        performSegue(withIdentifier: "fromTableToEditor", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> CustomTableCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell", for: indexPath) as! CustomTableCell
        let meme = memes[(indexPath as NSIndexPath).row]

        cell.memeImage.image = meme.originalImage

        cell.memeDescription.text = meme.topText+" "+meme.bottomText

        return cell
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromTableToDisplay" {
            let vc = segue.destination as! MemeDisplayViewController
            vc.displayedMeme = chosenMeme
        }
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenMeme = memes[indexPath.row]
        performSegue(withIdentifier: "fromTableToDisplay", sender: nil)
    }

}
