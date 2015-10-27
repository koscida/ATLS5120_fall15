//
//  ListManager.swift
//  lists-beta-0.2
//
//  Created by Brittany Kos on 10/25/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import Foundation
import CoreData

class ListManager {
    
    var testing = true
    
    var lists = [ListModel]()
    var listsGen = [NSDictionary]()
    
    
    init() {
        
        if(testing) {
            
            for var i=1; i<16; i++ {
                listsGen.append(["id" : i, "name": "aaa\(i)"])
            }
            //println(listsGen)
        }
    }
    
    
    func addNewList() -> Int {
        var nID = nextID()
        listsGen.append(["id" : nID, "name": "aaa\(nID)"])
        
        return nID
    }
    
    func nextID() -> Int {
        return listsGen.count + 1
    }
}