//
//  RealmCrud.swift
//  AssuitGuideBook
//
//  Created by Khalid on 11/26/19.
//  Copyright © 2019 Khalid. All rights reserved.
//

import Foundation
import RealmSwift

class RealmCrud {
    
    class func insert(item: FavouriteItem)
    {
        let realm: Realm = try! Realm()
        
        try! realm.write {
            realm.add(item)
        }
    }
    
    class func deleteItem(name: String)
    {
        let realm: Realm = try! Realm()
        
        let predicate = NSPredicate(format: "name = %@", name)
        try! realm.write {
            realm.delete(realm.objects(FavouriteItem.self).filter(predicate))
        }
    }
    
    class func readType(type: String) -> Results<FavouriteItem> {
        let realm: Realm = try! Realm()
        let predicate = NSPredicate(format: "imageName = %@", type)
        return realm.objects(FavouriteItem.self).filter(predicate)
    }
    
    class func readItem(name: String) -> FavouriteItem? {
        let realm: Realm = try! Realm()
        let predicate = NSPredicate(format: "name = %@", name)
        let result = realm.objects(FavouriteItem.self).filter(predicate)
        if result.count > 0 {
            return result[0]
        }
        else {
            return nil
        }
    }
    
}
