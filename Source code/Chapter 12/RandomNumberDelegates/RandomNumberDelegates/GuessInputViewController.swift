//
//  GuessInputViewController.swift
//  RandomNumberDelegates
//
//  Created by Gary Bennett on 11/9/14.
//  Copyright (c) 2014 xcelMe. All rights reserved.
//

import UIKit

//protocol used to send data back the home view controller's userDidFinish
protocol GuessDelegate{
    func userDidFinish(controller:GuessInputViewController,guess:String)
}

class GuessInputViewController: UIViewController,  UITextFieldDelegate {
    
    var delegate:GuessDelegate? = nil
    var previousGuess:String = ""
    
    
    @IBOutlet weak var guessLabelOutlet: UILabel!
    @IBOutlet weak var guessTextOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if(!previousGuess.isEmpty){
            guessLabelOutlet.text = "Your previous guess was \(previousGuess)"
        }
        guessTextOutlet.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveGuessAction(sender: AnyObject) {
        if (delegate != nil){
            delegate!.userDidFinish(self, guess: guessTextOutlet.text!)
        }
    }
    
}
