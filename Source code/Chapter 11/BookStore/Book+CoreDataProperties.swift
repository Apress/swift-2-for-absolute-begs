//
//  Book+CoreDataProperties.swift
//  BookStore
//
//  Created by Brad Lees on 8/8/15.
//  Copyright © 2015 Inn. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

import Foundation
import CoreData

extension Book {

    @NSManaged var title: String?
    @NSManaged var price: NSNumber?
    @NSManaged var yearPublished: NSNumber?
    @NSManaged var author: NSManagedObject?

}
