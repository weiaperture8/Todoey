//
//  Item.swift
//  Todoey
//
//  Created by Wei Ho on 2019/2/27.
//  Copyright © 2019 Wei Ho. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated : String = ""
    
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items") //Many to one, inverse relationship linking to Category type with items which created in the Cateogry
}
