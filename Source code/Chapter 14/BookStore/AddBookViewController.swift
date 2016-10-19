//
//  AddBookViewController.swift
//  BookStore
//
//  Created by Gary Bennett on 11/11/14.
//  Copyright (c) 2014 xcelMe. All rights reserved.
//

import UIKit

protocol BookStoreDelegate{
    func newBook(controller:AnyObject,newBook:Book)
    func editBook(controller:AnyObject,editBook:Book)
    func deleteBook(controller:AnyObject)
}




class AddBookViewController: UIViewController {
    var book = Book()
    var delegate:BookStoreDelegate? = nil
    var read = false;
    var editBook = false;
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var authorText: UITextField!
    @IBOutlet weak var pagesText: UITextField!
    @IBOutlet weak var switchOutlet: UISwitch!
    
    @IBOutlet weak var descriptionText: UITextView!
   

    override func viewDidLoad() {
        super.viewDidLoad()
        if(editBook == true){
            self.title = "Edit Book"
            titleText.text = book.title
            authorText.text = book.author
            pagesText.text = String(book.pages)
            descriptionText.text = book.description
            if (book.readThisBook){
                switchOutlet.on = true
            }
            else {
               switchOutlet.on = false
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveBookAction(sender: UIButton) {
        book.title = titleText.text!
        book.author = authorText.text!
        book.description = descriptionText.text
        book.pages = Int(pagesText.text!)!
        if(switchOutlet.on) {
          book.readThisBook = true
        }
        else {
          book.readThisBook = false
        }
        if (editBook) {
            delegate!.editBook(self, editBook:book)
        }
        else {
            delegate!.newBook(self, newBook:book)
        }
        
        
    }
    

}
