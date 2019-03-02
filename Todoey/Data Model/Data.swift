//
//  Data.swift
//  Todoey
//
//  Created by Wei Ho on 2019/2/26.
//  Copyright © 2019 Wei Ho. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var score : Int = 0
    @objc dynamic var pass : Bool = true
}
