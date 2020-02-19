//
//  ViewController.swift
//  Roshando
//
//  Created by Shailaja on 12/01/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import UIKit

class SelectionViewController: UIViewController {
    
    var computerSelection = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func computerPlays(){
        self.computerSelection = Int.random(in:0...2)
    }
    
    let resultsDict = [1:"Paper wraps Rock!",2:"Rock smashes Scissors!",3:"Scissors cut Paper!"]
    
    func resolve(playerSelection p:Int, computerSelection c:Int)->String{
        if p==c{
            return "It's a tie!"
        }
        return resultsDict[p+c]! + " You " + (p%3==(c+1)%3 ? "Win" : "Lose") + "!"
    }

    @IBAction func pressRock(_ sender: Any) {
        
        computerPlays()
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        
        controller.labelText = resolve(playerSelection:0,computerSelection:computerSelection)
        
        controller.imageIdentifier = "Image\(computerSelection==0 ? 0 : computerSelection)"
        
        present(controller, animated: true, completion: nil)
    }
    
    override func prepare(for segue:UIStoryboardSegue,sender: Any?){
        computerPlays()
        let controller = segue.destination as! ResultViewController
        let playerSelection =  segue.identifier=="paperSegue" ? 1 : 2
        controller.labelText = resolve(playerSelection:playerSelection,computerSelection:computerSelection)
        
        controller.imageIdentifier = "Image\(computerSelection==playerSelection ? 0 : computerSelection+playerSelection)"
    }
    
    @IBAction func pressPaper(_ sender: Any){
        performSegue(withIdentifier: "paperSegue", sender:self)
    }
    
}

