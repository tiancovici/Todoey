//
//  Item.swift
//  Todoey
//
//  Created by Tom Iancovici on 12/25/18.
//  Copyright © 2018 Tom Iancovici. All rights reserved.
//

import Foundation

class Item {
    var title: String = ""
    var done: Bool = false
    init(_ title: String) {
        self.title = title
    }
}
