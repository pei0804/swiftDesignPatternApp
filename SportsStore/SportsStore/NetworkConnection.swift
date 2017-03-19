//
//  NetworkConnection.swift
//  SportsStore
//
//  Created by jumpei on 2017/03/19.
//  Copyright © 2017年 Apress. All rights reserved.
//

import Foundation

class NetworkConnection {
    private let stockData: [String: Int] = [
        "Pei": 10,"LifeJacket": 14, "soccer ball": 32, "flags": 1,
        "stadium": 12, "cup": 1, "chair": 10
    ]

    func getStockLevel(name: String) -> Int? {
        Thread.sleep(forTimeInterval: Double(arc4random() % 2))
        return stockData[name]
    }
}
