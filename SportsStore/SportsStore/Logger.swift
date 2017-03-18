//
//  Logger.swift
//  SportsStore
//
//  Created by jumpei on 2017/03/18.
//  Copyright © 2017年 Apress. All rights reserved.
//

import Foundation

let productLogger = Logger<Product>(callback: {p in
    print("change \(p.name) \(p.stockLevel)")
})

final class Logger<T> where T: NSObject, T: NSCopying {
    var dataItems: [T] = []
    var callback: (T) -> Void
    var concurrentQueue = DispatchQueue(label: "concurrent-queue", attributes: .concurrent)
    var serialQueue = DispatchQueue(label: "serial-queue")

    fileprivate init(callback: @escaping (T) -> Void, protect: Bool = true) {
        self.callback = callback
        if(protect) {
            self.callback = {(item: T) in
                self.serialQueue.async {
                    callback(item)
                }
            }
        }
    }

    func logItem(item: T) {
        concurrentQueue.async {
            self.dataItems.append(item.copy() as! T)
            self.callback(item)
        }
    }

    func processItems(callback: (T) -> Void) {
        concurrentQueue.async {
            for item in self.dataItems {
                self.callback(item)
            }
        }
    }
}
