//
//  Customer.swift
//  BookStore
//
//  Created by Brad Lees on 6/27/15.
//  Copyright © 2015 Brad Lees. All rights reserved.
//

import Foundation

class Customer {
    var firstName = ""
    var lastName = ""
    var addressLine1 = ""
    var addressLine2 = ""
    var city = ""
    var state = ""
    var zip = ""
    var phoneNumber = ""
    var emailAddress = ""
    var favoriteGenre = ""
    
    func listPurchaseHistory() -> [String] {
        return ["Purchase 1", "Purchase 2"]
    }
}
