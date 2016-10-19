//
//  DetailViewController.swift
//  Chapter 8.1
//
//  Created by Brad Lees on 11/9/14.
//  Copyright (c) 2014 mycompany.com. All rights reserved.
//

import UIKit



class DetailViewController: UIViewController  {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
  
    
    @IBOutlet weak var pagesOutlet: UILabel!
    @IBOutlet weak var switchOutlet: UISwitch!
    
    var delegate:BookStoreDelegate? = nil
    
    var myBook = Book()
    
    
   

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editDetail" {
            let vc = segue.destinationViewController as! AddBookViewController
            vc.delegate = delegate
            vc.editBook = true
            vc.book = myBook
            
        }
    }
    
    func configureView() {
        if let detail: AnyObject = self.detailItem {
            myBook = detail as! Book
            titleLabel.text = myBook.title
            authorLabel.text = myBook.author
            descriptionTextView.text = myBook.description
            pagesOutlet.text = String(myBook.pages)
            if(myBook.readThisBook){
                switchOutlet.on = true
            }
            else {
                switchOutlet.on = false
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteBookAction(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Warning", message: "Delete this book?", preferredStyle: .Alert)
        let noAction = UIAlertAction(title: "No", style: .Cancel) { (action) in
            print("Cancel")
        }
        alertController.addAction(noAction)
        
        let yesAction = UIAlertAction(title: "Yes", style: .Destructive) { (action) in
           self.delegate!.deleteBook(self)
        }
        alertController.addAction(yesAction)
        
        self.presentViewController(alertController, animated: false, completion: nil)
    }
    
    
   
}

