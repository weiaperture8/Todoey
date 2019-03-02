//
//  Category.swift
//  Todoey
//
//  Created by Wei Ho on 2019/2/27.
//  Copyright © 2019 Wei Ho. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()  // One to Many Relationship
}
