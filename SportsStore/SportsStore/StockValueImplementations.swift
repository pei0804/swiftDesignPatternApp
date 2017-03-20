//
//  StockValueImplementations.swift
//  SportsStore
//
//  Created by jumpei on 2017/03/20.
//  Copyright © 2017年 Apress. All rights reserved.
//

import Foundation

protocol StockValueFormatter {
    func formatToal(total: Double) -> String
}

class DollarStockValueFormatter: StockValueFormatter {
    func formatToal(total: Double) -> String {
        let formatted = Utils.currencyStringFromNumber(total)
        return "\(formatted)"
    }
}

class PoundStockValueFormatter: StockValueFormatter {
    func formatToal(total: Double) -> String {
        let formatted = Utils.currencyStringFromNumber(total)
        return "£\((formatted))"
    }
}

protocol StockValueConverter {
    func convertTotal(total: Double) -> Double
}

class DollarStockValueConverter : StockValueConverter {
    func convertTotal(total: Double) -> Double {
        return total
    }
}

class PoundStockValueConverter: StockValueConverter {
    func convertTotal(total: Double) -> Double {
        return 0.60338 * total
    }
}
