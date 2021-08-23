//
//  Order.swift
//  SalesRecord
//
//  Created by Salman on 8/23/21.
//

import UIKit

class Order: Codable {
    
    var items = [Item]()
    var totalPrice: Float = 0
    var orderDate: Date!
    
}
