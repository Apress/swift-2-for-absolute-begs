//
//  ViewController.swift
//  RandomNumberDelegates
//
//  Created by Gary Bennett on 8/10/15.
//  Copyright (c) 2015 xcelMe. All rights reserved.
//

import UIKit

class ViewController: UIViewController,GuessDelegate {
    
    var previousGuess = ""
    var randomNumber = 0
    
    
    @IBOutlet weak var userGuessLabelOutlet: UILabel!
    @IBOutlet weak var outComeLabelOutlet: UILabel!
    @IBOutlet weak var playAgainButtonOutlet: UIButton!
    @IBOutlet weak var guessButtonOutlet: UIButton!
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "MyGuessSegue"{
            let vc = segue.destinationViewController as! GuessInputViewController
            vc.previousGuess = previousGuess // passes the last guess the previousGuess property in the GuessInputViewController
            vc.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.createRandomNumber()
        playAgainButtonOutlet.hidden = true;
        outComeLabelOutlet.text = ""
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //event triggered by playAgain Button
    @IBAction func playAgainAction(sender: AnyObject) {
        createRandomNumber()
        playAgainButtonOutlet.hidden = true //only show the button when the user guessed the right #
        guessButtonOutlet.hidden = false //show the button
        outComeLabelOutlet.text = ""
        userGuessLabelOutlet.text = "New Game"
        previousGuess = ""
    }
    
    //function called from the GuessInputViewController when the user taps on the Save Button button
   func userDidFinish(controller: GuessInputViewController, guess: String) {
        userGuessLabelOutlet.text = "The guess was " +  guess
        previousGuess = guess
        let numberGuess = Int(guess)
        if (numberGuess > randomNumber){
            outComeLabelOutlet.text = "Guess too high"
        }
        else if (numberGuess < randomNumber) {
            outComeLabelOutlet.text = "Guess too low"
        }
        else {
            outComeLabelOutlet.text = "Guess is correct"
            playAgainButtonOutlet.hidden = false //show the play again button
            guessButtonOutlet.hidden = true //hide the guess again number
        }
        //pops the GuessInputViewController off the stack
        controller.navigationController?.popViewControllerAnimated(true)
    }
    //creates the random number
    func createRandomNumber() {
        randomNumber = Int(arc4random_uniform(100)) //get a random number between 0-100
        print("The random number is: \(randomNumber)") //lets us cheat
        return
    }
    
    
}


