//
//  BookStore.swift
//  BookStore
//
//  Created by Thorn on 8/8/15.
//  Copyright © 2015 Inn. All rights reserved.
//

import Foundation

class BookStore {
    var theBookStore:[Book] = []
    
    init() {
        var newBook = Book()
        newBook.title = "Swift for Absolute Beginners"
        newBook.author = "Bennett and Lees"
        newBook.description = "Swift programming made easy."
        theBookStore.append(newBook)
        
        newBook = Book()
        newBook.title = "A Farewell to Arms"
        newBook.author = "Ernest Hemingway"
        newBook.description = "The story of an afair between an English nurse and an American soldier on the Italian front during World Ward I."
        theBookStore.append(newBook)
        /*
        newBook = Book()
        newBook.title = "Testing"
        newBook.author = "Testing Author"
        newBook.description = "Testing Desc"
        theBookStore.append(newBook)
        
        newBook = Book()
        newBook.title = "Testing2"
        newBook.author = "Testing Author"
        newBook.description = "Testing Desc"
        theBookStore.append(newBook)
        
        newBook = Book()
        newBook.title = "Testing3"
        newBook.author = "Testing Author"
        newBook.description = "Testing Desc"
        theBookStore.append(newBook)
        
        newBook = Book()
        newBook.title = "Testing4"
        newBook.author = "Testing Author"
        newBook.description = "Testing Desc"
        theBookStore.append(newBook)
        */
        
        
    }

}


