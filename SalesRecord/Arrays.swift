//
//  Arrays.swift
//  SalesRecord
//
//  Created by Salman on 8/23/21.
//

import UIKit

class Arrays {
    
    var allItems: [Item]
    var currentOrder = Order()
    var pastOrders: [Order]
    
    let allItemsSaveURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("allItems.plist")
    let pastOrdersSaveURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("pastOrders.plist")
    
    let nF: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    init() {
        if let allItems = try? PropertyListDecoder().decode([Item].self, from: Data(contentsOf: allItemsSaveURL)) {
            self.allItems = allItems
        } else {
            self.allItems = [Item]()
        }
        
        if let pastOrders = try? PropertyListDecoder().decode([Order].self, from: Data(contentsOf: pastOrdersSaveURL)) {
            self.pastOrders = pastOrders
        } else {
            self.pastOrders = [Order]()
        }
    }
    
    func nameAlreadyExists(_ name: String?) -> Bool {
        if name == nil {
            return false
        }
        
        for i in 0..<allItems.count {
            if (allItems[i].name == name) {
                return true
            }
        }
        
        return false
    }
    
    func formatPrice(_ value: Float) -> String {
        return "\(Locale.current.currencySymbol ?? "$")\(nF.string(from: NSNumber(value: value)) ?? "")"
    }
    
}
