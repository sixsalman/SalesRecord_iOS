//
//  AddViewController.swift
//  SalesRecord
//
//  Created by Salman on 8/23/21.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {
    
    var arrays: Arrays!
    var itemsTableView: UITableView!
    
    let nF: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var itemNameField: UITextField!
    @IBOutlet var priceField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        priceLabel.text = "Price (\(Locale.current.currencySymbol ?? "$")):"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        itemNameField.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let decimalSeparator = Locale.current.decimalSeparator ?? "."
        
        var allowedChars = CharacterSet(charactersIn: "0123456789")
        allowedChars.insert(charactersIn: decimalSeparator)

        if string.rangeOfCharacter(from: allowedChars.inverted) != nil {
            return false
        }
        
        if textField.text?.range(of: decimalSeparator) != nil, string.range(of: decimalSeparator) != nil {
            return false
        }
        
        if string.range(of: decimalSeparator) != nil, string.replacingOccurrences(of: decimalSeparator, with: "").count != string.count - 1 {
            return false
        }
        
        return true
    }
    
    @IBAction func addBtnTapped(_ sender: UIButton) {
        if !arrays.nameAlreadyExists(itemNameField.text) {
            arrays.allItems.append(Item(String(itemNameField.text ?? ""), nF.number(from: priceField.text ?? "0")!.floatValue))
            
            itemsTableView.reloadData()
            
            dismiss(animated: true, completion: nil)
            
            try? PropertyListEncoder().encode(arrays.allItems).write(to: arrays.allItemsSaveURL, options: [.atomic])
        } else {
            let msgBox = UIAlertController(title: "", message: "An item of the same name already exists", preferredStyle: UIAlertController.Style.alert)
            
            msgBox.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            
            present(msgBox, animated: true, completion: nil)
        }
    }
    
}
