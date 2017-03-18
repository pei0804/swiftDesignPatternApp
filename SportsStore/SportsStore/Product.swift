//
//  Product.swift
//  SportsStore
//
//  Created by jumpei on 2017/03/17.
//  Copyright © 2017年 Apress. All rights reserved.
//

import Foundation

class Product: NSObject, NSCopying {
    private(set) var name: String = ""
    private(set) var productDescription: String = ""
    private(set) var category: String = ""
    private var stockLevelBackingValue: Int = 0
    private var priceBackingValue: Double = 0

    init(name: String, description: String, category: String, price: Double, stockLevel: Int) {
        self.name = name
        self.productDescription = description
        self.category = category
        super.init()
        self.price = price
        self.stockLevel = stockLevel
    }

    var stockLevel: Int {
        get { return stockLevelBackingValue }
        set { stockLevelBackingValue = max(0, newValue) }
    }

    private(set) var price: Double {
        get { return priceBackingValue}
        set { return priceBackingValue = max(1, newValue) }
    }

    var stockValue: Double {
        get { return self.price * Double(stockLevel) }
    }

    func copy(with zone: NSZone? = nil) -> Any {
        return Product(name: self.name, description: self.description, category: self.description, price: self.price, stockLevel: self.stockLevel)
    }
}
