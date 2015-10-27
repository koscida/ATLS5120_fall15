//
//  ListModel.swift
//  lists-beta-0.2
//
//  Created by Brittany Kos on 10/25/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//
//  http://jamesonquave.com/blog/core-data-in-swift-tutorial-part-2/

import Foundation
import CoreData

@objc(ListModel)
class ListModel: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var id: NSInteger
        
    
}
