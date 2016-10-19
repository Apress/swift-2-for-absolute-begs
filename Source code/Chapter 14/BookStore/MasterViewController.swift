//
//  MasterViewController.swift
//  Chapter 8.1
//
//  Created by Brad Lees on 11/9/14.
//  Copyright (c) 2014 mycompany.com. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController,BookStoreDelegate {

    var objects = NSMutableArray()
    var myBookStore = BookStore()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.navigationItem.leftBarButtonItem = self.editButtonItem()

        //let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        //self.navigationItem.rightBarButtonItem = addButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
/*
    func insertNewObject(sender: AnyObject) {
        objects.insertObject(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
*/
    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedBook:Book = myBookStore.theBookStore[indexPath.row]
                let vc = segue.destinationViewController as! DetailViewController
                vc.detailItem = selectedBook
                vc.delegate = self
            }
        }
        else if segue.identifier == "addBookSegue" {
            let vc = segue.destinationViewController as! AddBookViewController
            vc.delegate = self
        }
        
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myBookStore.theBookStore.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = myBookStore.theBookStore[indexPath.row].title
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    // MARK: - Delegate Methods conforming to the protocol BookStoreDelegate as defined in the AddBookViewController
    func newBook(controller:AnyObject,newBook:Book) {
        myBookStore.theBookStore.append(newBook)
        self.tableView.reloadData()
        let myController = controller as! AddBookViewController
        myController.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func deleteBook(controller:AnyObject){
        let indexPath = self.tableView.indexPathForSelectedRow
        let row = indexPath?.row
        myBookStore.theBookStore.removeAtIndex(row!)
        self.tableView.reloadData()
        let myController = controller as! DetailViewController
        myController.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func editBook(controller:AnyObject,editBook:Book){
        let indexPath = self.tableView.indexPathForSelectedRow
        let row = indexPath?.row
        myBookStore.theBookStore.insert(editBook, atIndex: row!)
        myBookStore.theBookStore.removeAtIndex(row!+1)
        self.tableView.reloadData()
        let myController = controller as! AddBookViewController
        myController.navigationController?.popToRootViewControllerAnimated(true)
    }


}

