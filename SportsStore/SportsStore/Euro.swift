//
//  Euro.swift
//  SportsStore
//
//  Created by jumpei on 2017/03/21.
//  Copyright © 2017年 Apress. All rights reserved.
//

import Foundation

class EuroHandler {
    func getDisplayString(amount: Double) -> String {
        let formatted = Utils.currencyStringFromNumber(amount)
        return "€\(formatted)"
    }

    func getCurrencyAmount(amount: Double) -> Double {
        return 0.76164 * amount
    }
}
