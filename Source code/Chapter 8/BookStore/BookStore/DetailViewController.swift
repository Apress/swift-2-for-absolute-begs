//
//  DetailViewController.swift
//  BookStore
//
//  Created by Brad Lees on 8/8/15.
//  Copyright © 2015 Inn. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    @IBOutlet weak var descriptionTextView: UITextView!
    
    var detailItem: AnyObject? {
        didSet {

        }
    }

    func configureView() {
        if let detail:AnyObject = self.detailItem {
            var myBook: Book = detail as! Book
            titleLabel.text = myBook.title
            authorLabel.text = myBook.author
            descriptionTextView.text = myBook.description
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


}

