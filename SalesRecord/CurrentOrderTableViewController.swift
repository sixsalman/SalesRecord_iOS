//
//  CurrentOrderTableViewController.swift
//  SalesRecord
//
//  Created by Salman on 8/23/21.
//

import UIKit

class CurrentOrderTableViewController: UITableViewController {

    var arrays: Arrays!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        navigationItem.title = "Total: \(arrays.formatPrice(arrays.currentOrder.totalPrice))"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrays.currentOrder.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        cell.textLabel?.text = arrays.currentOrder.items[indexPath.row].name
        cell.detailTextLabel?.text = "\(arrays.formatPrice(arrays.currentOrder.items[indexPath.row].price))"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrays.currentOrder.totalPrice -= arrays.currentOrder.items[indexPath.row].price
            
            arrays.currentOrder.items.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            navigationItem.title = "Total: \(arrays.formatPrice(arrays.currentOrder.totalPrice))"
        }
    }
    
    @IBAction func completeOrderBtn(_ sender: UIButton) {
        arrays.currentOrder.orderDate = Date()
        
        arrays.pastOrders.append(arrays.currentOrder)
        
        arrays.currentOrder = Order()
        
        tableView.reloadData()
        navigationItem.title = "Total: \(arrays.formatPrice(arrays.currentOrder.totalPrice))"
        
        try? PropertyListEncoder().encode(arrays.pastOrders).write(to: arrays.pastOrdersSaveURL, options: [.atomic])
    }
    
}
