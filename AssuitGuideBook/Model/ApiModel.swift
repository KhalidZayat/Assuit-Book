//
//  ApiModel.swift
//  AssuitGuideBook
//
//  Created by Khalid on 11/16/19.
//  Copyright © 2019 Khalid. All rights reserved.
//

import Foundation

struct ApiModel: Decodable {
    let result: String
    let data: [data]
}

struct data: Decodable
{
    let phone, name, address: String
    
    enum CodingKeys: String, CodingKey {
        case phone = "Phone"
        case name = "Name"
        case address = "Address"
    }
}

