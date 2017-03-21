//
//  StockValueFactories.swift
//  SportsStore
//
//  Created by jumpei on 2017/03/20.
//  Copyright © 2017年 Apress. All rights reserved.
//

import Foundation

class StockTotalFactory {
    enum Currency {
        case USD
        case GBP
        case EUR
    }

    fileprivate(set) var formatter: StockValueFormatter?
    fileprivate(set) var converter: StockValueConverter?

    class func getFactory(curr: Currency) -> StockTotalFactory {
        if curr == Currency.USD {
            return DollarStockTotalFactory.sharedInstance
        } else if curr == Currency.GBP {
            return PoundStockTotalFactory.sharedInstance
        } else {
            return EuroHandlerAdapter.shardInstance
        }
    }
}

private class DollarStockTotalFactory: StockTotalFactory {
    private override init() {
        super.init()
        formatter = DollarStockValueFormatter()
        converter = DollarStockValueConverter()
    }

    class var sharedInstance: StockTotalFactory {
        get {
            struct SingletonWrapper {
                static let singleton = DollarStockTotalFactory()
            }
            return SingletonWrapper.singleton
        }
    }
}

private class PoundStockTotalFactory: StockTotalFactory {
    private override init() {
        super.init()
        formatter = PoundStockValueFormatter()
        converter = PoundStockValueConverter()
    }

    class var sharedInstance: StockTotalFactory {
        get {
            struct SingletonWrapper {
                static let singleton = PoundStockTotalFactory()
            }
            return SingletonWrapper.singleton
        }
    }
}

class EuroHandlerAdapter: StockTotalFactory, StockValueConverter, StockValueFormatter {
    private let handler: EuroHandler

    override init() {
        self.handler = EuroHandler()
        super.init()
        super.formatter = self
        super.converter = self
    }

    func formatToal(total: Double) -> String {
        return handler.getDisplayString(amount: total)
    }

    func convertTotal(total: Double) -> Double {
        return handler.getCurrencyAmount(amount: total)
    }

    class var shardInstance: EuroHandlerAdapter {
        get {
            struct SingletonWrapper {
                static let singleton = EuroHandlerAdapter()
            }
            return SingletonWrapper.singleton
        }
    }
}
