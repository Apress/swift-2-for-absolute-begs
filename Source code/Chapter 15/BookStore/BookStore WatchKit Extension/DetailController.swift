//
//  detailController.swift
//  BookStore
//
//  Created by Brad Lees on 9/12/15.
//  Copyright © 2015 innv. All rights reserved.
//

import Foundation
import WatchKit



class DetailController: WKInterfaceController {
    @IBOutlet var labelTitle: WKInterfaceLabel!
    @IBOutlet var labelAuthor: WKInterfaceLabel!
    @IBOutlet var labelDescription: WKInterfaceLabel!
    
    var book:Book!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let book = context as? Book {
            labelTitle.setText(book.title)
            labelAuthor.setText(book.author)
            labelDescription.setText(book.description)
        }
        
        
    }
    
    
    
    
    
}