//
//  ViewController.swift
//  RandomNumber
//
//  Created by Gary Bennett on 7/2/15.
//  Copyright (c) 2015 xcelMe. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

 
    @IBOutlet weak var randomNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func seedAction(sender: UIButton) {
        srandom(CUnsignedInt(time(nil)))
        randomNumberLabel.text = "Generator seended"
    }


    @IBAction func generateAction(sender: UIButton) {
        let generated = (random() % 100) + 1
        randomNumberLabel.text = "\(generated)"
    }
}

