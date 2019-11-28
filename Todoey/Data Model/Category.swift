//
//  Category.swift
//  Todoey
//
//  Created by Hani Joudeh on 11/26/19.
//  Copyright © 2019 Hani Joudeh. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    
    let items = List<Item>()
    
}
