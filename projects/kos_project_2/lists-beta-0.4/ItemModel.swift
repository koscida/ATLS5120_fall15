//
//  Item.swift
//  lists-beta-0.2
//
//  Created by Brittany Kos on 10/27/15.
//  Copyright (c) 2015 Kode Studios. All rights reserved.
//

import Foundation
import CoreData

@objc(ItemModel)
class ItemModel: NSManagedObject {

    @NSManaged var text: String
    @NSManaged var complete: NSNumber
    @NSManaged var sub: ListModel

}
