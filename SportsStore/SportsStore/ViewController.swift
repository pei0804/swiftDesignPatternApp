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
    var product: Product?
}

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var totalStockLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var productStore = ProductDataStore()

    var products = [
        Product.createProduct(name: "A", description: "A Desc", category: "1", price: 275.0, stockLevel: 10),
        Product.createProduct(name: "B", description: "B Desc", category: "2", price: 48.95, stockLevel: 14),
        Product.createProduct(name: "C", description: "C Desc", category: "2", price: 19.5, stockLevel: 32),
        Product.createProduct(name: "D", description: "D Desc", category: "3", price: 34.95,stockLevel:  1),
        Product.createProduct(name: "E", description: "E Desc", category: "3", price: 79500.0, stockLevel: 4),
        Product.createProduct(name: "F", description: "F Desc", category: "3", price: 16.0, stockLevel: 8),
        Product.createProduct(name: "G", description: "G Desc", category: "4", price: 29.95, stockLevel: 3),
        Product.createProduct(name: "H", description: "H Desc", category: "4", price: 75.0, stockLevel: 2),
        Product.createProduct(name: "I", description: "I Desc", category: "4", price: 1200.0, stockLevel: 4)
    ]                                                                                    

    override func viewDidLoad() {
        super.viewDidLoad()
        displayStockTotal()

        productStore.callback = {(p: Product) in
            for cell in self.tableView.visibleCells {
                if let pcell = cell as? ProductTableCell {
                    pcell.stockStepper.value = Double(p.stockLevel)
                    pcell.stockField.text = String(p.stockLevel)
                }
            }
            self.displayStockTotal()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func displayStockTotal() {
        let finalTotals:(Int, Double) = productStore.products.reduce((0, 0.0), {(total, products) -> (Int, Double) in return (
            total.0 + products.stockLevel,
            total.1 + products.stockValue
            )
        })
        totalStockLabel.text = "\(finalTotals.0) \(Utils.currencyStringFromNumber(finalTotals.1))"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productStore.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = productStore.products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductTableCell
        cell.product = product
        cell.nameLabel.text = product.name
        cell.descriptionLabel.text = product.productDescription
        cell.stockStepper.value = Double(product.stockLevel)
        cell.stockField.text = String(product.stockLevel)
        return cell
    }
    
    @IBAction func stockLevelDidChange(_ sender: AnyObject) {
        if var currentCell = sender as? UIView {
            while (true) {
                currentCell = currentCell.superview!
                if let cell = currentCell as? ProductTableCell {
                    if let product = cell.product {
                        if let stepper = sender as? UIStepper {
                            product.stockLevel = Int(stepper.value)
                        }
                        else if let textfield = sender as? UITextField {
                            if let newValue = textfield.text {
                                guard let newValueWrp = Int(newValue) else { return }
                                product.stockLevel = newValueWrp
                            }
                        }
                        cell.stockStepper.value = Double(product.stockLevel)
                        cell.stockField.text = String(product.stockLevel)
                        productLogger.logItem(item: product)
                    }
                    break
                }
            }
            displayStockTotal()
        }
    }
}
