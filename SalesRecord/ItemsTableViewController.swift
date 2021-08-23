//
//  ItemsTableViewController.swift
//  SalesRecord
//
//  Created by Salman on 8/22/21.
//

import UIKit

class ItemsTableViewController: UITableViewController {

    var arrays: Arrays!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrays.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemsTableViewCell", for: indexPath) as! ItemsTableViewCell
        
        cell.label.text = "\(arrays.allItems[indexPath.row].name) - \(arrays.formatPrice(arrays.allItems[indexPath.row].price))"
        cell.addToCartBtn.tag = indexPath.row
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrays.allItems.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            try? PropertyListEncoder().encode(arrays.allItems).write(to: arrays.allItemsSaveURL, options: [.atomic])
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let toMove = arrays.allItems[sourceIndexPath.row]
        
        arrays.allItems.remove(at: sourceIndexPath.row)
        arrays.allItems.insert(toMove, at: destinationIndexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segue = segue.destination as! AddViewController
        
        segue.arrays = arrays
        segue.itemsTableView = tableView
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
        arrays.currentOrder.items.append(arrays.allItems[sender.tag])
        arrays.currentOrder.totalPrice += arrays.allItems[sender.tag].price
    }
    
}
