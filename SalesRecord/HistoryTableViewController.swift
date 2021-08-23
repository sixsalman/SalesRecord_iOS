//
//  HistoryTableViewController.swift
//  SalesRecord
//
//  Created by Salman on 8/23/21.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    var arrays: Arrays!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrays.pastOrders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        cell.textLabel?.text = "Order \(indexPath.row + 1)"
        cell.detailTextLabel?.text = "\(arrays.formatPrice(arrays.pastOrders[indexPath.row].totalPrice))"
        
        cell.tag = indexPath.row
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segue = segue.destination as! PastOrderTableViewController
        let cell = sender as! UITableViewCell
        
        segue.arrays = arrays
        segue.order = arrays.pastOrders[cell.tag]
    }
    
}
