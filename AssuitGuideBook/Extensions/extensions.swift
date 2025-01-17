//
//  extensions.swift
//  AssuitGuideBook
//
//  Created by Khalid on 11/20/19.
//  Copyright © 2019 Khalid. All rights reserved.
//
import RealmSwift

extension Results {
    func toArray() -> [Element] {
        return compactMap {
            $0
        }
    }
}
