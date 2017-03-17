//
//  Utils.swift
//  SportsStore
//
//  Created by jumpei on 2017/03/17.
//  Copyright © 2017年 Apress. All rights reserved.
//

import Foundation

class Utils {
    class func currencyStringFromNumber(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        return formatter.string(from: number as NSNumber) ?? ""
    }
}
