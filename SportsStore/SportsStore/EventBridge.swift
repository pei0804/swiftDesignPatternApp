//
//  EventBridge.swift
//  SportsStore
//
//  Created by jumpei on 2017/03/23.
//  Copyright © 2017年 Apress. All rights reserved.
//

import Foundation

class EventBridge {
    private let outputCallback:(String, Int) -> Void

    init(callback:@escaping (String, Int) -> Void) {
        self.outputCallback = callback
    }

    var inputCallback:(Product) -> Void {
        return { p in self.outputCallback(p.name, p.stockLevel) }
    }
}
