//
//  FavouriteItem.swift
//  AssuitGuideBook
//
//  Created by Khalid on 11/26/19.
//  Copyright © 2019 Khalid. All rights reserved.
//

import RealmSwift

class FavouriteItem: Object {
    @objc dynamic var name = ""
    @objc dynamic var phone = ""
    @objc dynamic var address = ""
    @objc dynamic var imageName = ""
    
    convenience init(name: String, phone: String, address: String, imageName: String) {
        self.init()
        self.name = name
        self.phone = phone
        self.address = address
        self.imageName = imageName
    }
}
