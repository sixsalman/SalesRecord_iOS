//
//  PastOrderTableViewController.swift
//  SalesRecord
//
//  Created by Salman on 8/23/21.
//

import UIKit

class PastOrderTableViewController: UITableViewController {

    var arrays: Arrays!
    var order: Order!
    
    let dF: DateFormatter = {
        let  formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.items.count + 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        if indexPath.row < order.items.count {
            cell.textLabel?.text = order.items[indexPath.row].name
            cell.detailTextLabel?.text = "\(arrays.formatPrice(order.items[indexPath.row].price))"
        } else if indexPath.row == order.items.count {
            cell.textLabel?.text = "Total"
            cell.detailTextLabel?.text = "\(arrays.formatPrice(order.totalPrice))"
            
            cell.backgroundColor = UIColor.quaternarySystemFill
        } else {
            cell.textLabel?.text = "Ordered"
            cell.detailTextLabel?.text = dF.string(from: order.orderDate)
            
            cell.backgroundColor = UIColor.quaternarySystemFill
        }
        
        return cell
    }
    
}
