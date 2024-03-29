//
//  Item.swift
//  Todoey
//
//  Created by Hani Joudeh on 11/26/19.
//  Copyright © 2019 Hani Joudeh. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
