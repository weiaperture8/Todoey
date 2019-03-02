//
//  RealmMigration.swift
//  Todoey
//
//  Created by Wei Ho on 2019/3/1.
//  Copyright © 2019 Wei Ho. All rights reserved.
//

import Foundation
import RealmSwift

class RealmMigration {
    
    
    func didApplicationLunch () {
        self.migrationVersion()
    }
    
    func migrationVersion() {
        
        
        let config = Realm.Configuration(
            
            schemaVersion : 1 ,
            
            migrationBlock : { migration , oldSchemaVersion in
                
                                if (oldSchemaVersion < 1) {
                                    migration.enumerateObjects(ofType: Item.className(), { (_, newItem) in
                                        newItem?["time"] = ""
                                    })
                                }
                
        }
            
        )
        
        Realm.Configuration.defaultConfiguration = config
        
    }
    
}

let realm = try! Realm()
