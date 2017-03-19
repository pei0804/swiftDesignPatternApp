//
//  ProductDataStore.swift
//  SportsStore
//
//  Created by jumpei on 2017/03/19.
//  Copyright © 2017年 Apress. All rights reserved.
//

import Foundation

final class ProductDataStore {
    var callback: ((Product) -> Void)?
    private var uiQueue: DispatchQueue
    private var networkQueue: DispatchQueue
    lazy var products: [Product] = self.loadData()

    init() {
        networkQueue = DispatchQueue(label: "network-queue", qos: .background)
        uiQueue = DispatchQueue.main
    }

    private func loadData() -> [Product] {
        for p in productData {
            networkQueue.sync {
                let stockConn = NetworkPool.getConnection()
                let level = stockConn.getStockLevel(name: p.name)
                if(level != nil) {
                    p.stockLevel = level!
                    uiQueue.sync {
                        if(self.callback != nil) {
                            self.callback!(p)
                        }
                    }
                }
                NetworkPool.returnConnection(conn: stockConn)
            }
        }
        return productData
    }

    private var productData: [Product] = [
        Product(name: "AA", description: "AA info", category: "10", price: 100.5, stockLevel: 0),
        Product(name: "BB", description: "BB info", category: "10", price: 120, stockLevel: 0),
        Product(name: "CC", description: "CC info", category: "11", price: 1000, stockLevel: 0),
        Product(name: "DD", description: "AA info", category: "11", price: 11.2, stockLevel: 0),
        Product(name: "EE", description: "AA info", category: "12", price: 300.1, stockLevel: 0),
        Product(name: "FF", description: "AA info", category: "12", price: 100, stockLevel: 0),
    ]
}
