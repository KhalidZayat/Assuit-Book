//
//  Item.swift
//  AssuitGuideBook
//
//  Created by Khalid on 11/14/19.
//  Copyright © 2019 Khalid. All rights reserved.
//

import Foundation

class Item
{
    var name = ""
    var phone = ""
    var address = ""
    var isSelected = false
    init(itemName: String , itemPhone: String , itemAddress: String ) {
        self.name = itemName
        self.phone = itemPhone
        self.address = itemAddress
    }
}
