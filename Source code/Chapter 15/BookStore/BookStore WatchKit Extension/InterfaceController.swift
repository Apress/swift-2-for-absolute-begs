//
//  InterfaceController.swift
//  BookStore WatchKit Extension
//
//  Created by Thorn on 9/1/15.
//  Copyright © 2015 innv. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet var mainTable: WKInterfaceTable!
    var myBookStore: BookStore = BookStore()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        configureTable()
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func configureTable() {
        
        
        mainTable.setNumberOfRows(myBookStore.theBookStore.count, withRowType: "MyBookRow")
        for index in 0...(myBookStore.theBookStore.count-1) {
            if let myRow = mainTable.rowControllerAtIndex(index) as! BookRow? {
                myRow.bookLabel.setText(myBookStore.theBookStore[index].title)
            }
        }
        
        
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        return myBookStore.theBookStore[rowIndex]
    }
    

}

class BookRow: NSObject {
    @IBOutlet weak var bookLabel: WKInterfaceLabel!
}
