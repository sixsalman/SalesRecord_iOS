//
//  Item.swift
//  SalesRecord
//
//  Created by Salman on 8/23/21.
//

import UIKit

class Item: Equatable, Codable {
    
    var name: String
    var price: Float
    
    init(_ name: String, _ price: Float) {
        self.name = name
        self.price = price
    }
    
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name && lhs.price == rhs.price
    }
    
}
