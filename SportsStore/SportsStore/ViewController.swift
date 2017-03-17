//
//  ViewController.swift
//  SportsStore
//
//  Created by jumpei on 2017/03/17.
//  Copyright © 2017年 Apress. All rights reserved.
//

import UIKit

class ProductTableCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stockStepper: UIStepper!
    @IBOutlet weak var stockField: UITextField!
    
    var productId: Int?
}

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var totalStockLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var products = [
        ("A", "A Desc", "Category 1", 275.0, 10),
        ("B", "B Desc", "Category 2", 48.95, 14),
        ("C", "C Desc", "Category 2", 19.5, 32),
        ("D", "D Desc", "Category 3", 34.95, 1),
        ("E", "E Desc", "Category 3", 79500.0, 4),
        ("F", "F Desc", "Category 3", 16.0, 8),
        ("G", "G Desc", "Category 4", 29.95, 3),
        ("H", "H Desc", "Category 4", 75.0, 2),
        ("I", "I Desc", "Category 4", 1200.0, 4)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        displayStockTotal()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func displayStockTotal() {
        let stockTotal = products.reduce(0, { (total, product) -> Int in return total + product.4 })
        totalStockLabel.text = "\(stockTotal) Products in Stock"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductTableCell
        cell.productId = indexPath.row
        cell.nameLabel.text = product.0
        cell.descriptionLabel.text = product.1
        cell.stockStepper.value = Double(product.4)
        cell.stockField.text = String(product.4)
        return cell
    }
    
    @IBAction func stockLevelDidChange(_ sender: AnyObject) {
        if var currentCell = sender as? UIView {
            while (true) {
                currentCell = currentCell.superview!
                if let cell = currentCell as? ProductTableCell {
                    if let id = cell.productId {
                        var newStockLevel: Int?

                        if let stepper = sender as? UIStepper {
                            newStockLevel = Int(stepper.value)
                        }
                        else if let textfield = sender as? UITextField {
                            if let newValue = textfield.text {
                                guard let newValueWrp = Int(newValue) else { return }
                                product.stockLevel = newValueWrp
                            }
                        }

                        if let level = newStockLevel {
                            products[id].4 = level
                            cell.stockStepper.value = Double(level)
                            cell.stockField.text = String(level)
                        }
                    }
                    break
                }
            }
            displayStockTotal()
        }
    }
}
