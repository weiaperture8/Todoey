//
//  Item.swift
//  Todoey
//
//  Created by Wei Ho on 2019/1/28.
//  Copyright © 2019 Wei Ho. All rights reserved.
//

import Foundation

class Item: Encodable, Decodable{
    var itemName: String = ""
    var done: Bool = false
}
