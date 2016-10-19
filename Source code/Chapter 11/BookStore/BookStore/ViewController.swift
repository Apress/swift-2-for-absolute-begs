//
//  ViewController.swift
//  BookStore
//
//  Created by Brad Lees on 8/8/15.
//  Copyright © 2015 Inn. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var myTableView: UITableView!

    var managedObjectContext: NSManagedObjectContext!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        managedObjectContext = appDelegate.managedObjectContext as NSManagedObjectContext
    }
    
    func loadBooks() -> [AnyObject] {
        //var error:NSError? = nil;
        let fetchRequest = NSFetchRequest(entityName: "Book")
        var result = [AnyObject]()
        do {
            result = try managedObjectContext!.executeFetchRequest(fetchRequest)
        } catch let error as NSError {
            NSLog("My Error: %@", error)
        }
        return result;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadBooks().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell?
        let book: Book = loadBooks()[indexPath.row] as! Book
        cell?.textLabel!.text = book.title
        return cell!
    }


    @IBAction func addNew(sender: AnyObject) {
        let book: Book = NSEntityDescription.insertNewObjectForEntityForName("Book", inManagedObjectContext: managedObjectContext) as! Book
        book.title = "My Book" + String(loadBooks().count)
        do {
            try managedObjectContext!.save()
        } catch let error as NSError {
            NSLog("My Error: %@", error)
        }
        myTableView.reloadData()
    }
}

