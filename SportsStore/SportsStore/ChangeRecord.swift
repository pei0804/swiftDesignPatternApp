//
//  ChangeRecord.swift
//  SportsStore
//
//  Created by jumpei on 2017/03/20.
//  Copyright © 2017年 Apress. All rights reserved.
//

import Foundation

class ChangeRecord {
    fileprivate let outerTag: String
    fileprivate let productName: String
    fileprivate let catName: String
    fileprivate let innerTag: String
    fileprivate let value: String

    fileprivate init(outer: String, name: String, category: String, inner: String, value: String) {
        self.outerTag = outer
        self.productName = name
        self.catName = category
        self.innerTag = inner
        self.value = value
    }

    var description: String {
        return "<\(self.outerTag)><\(self.innerTag) name=\"\(self.productName)\" category=\"\(self.catName)\">\(self.value)</\(self.innerTag)></\(self.outerTag)>"
    }
}

class ChangeRecordBuilder {
    var outerTag: String
    var innerTag: String
    var productName: String?
    var category: String?
    var value: String?

    init() {
        self.outerTag = "change"
        self.innerTag = "product"
    }

    var changeRecord: String? {
        get {
            if self.productName != nil && self.category != nil && self.value != nil {
                return ChangeRecord(outer:outerTag, name: self.productName!, category: self.category!, inner: self.innerTag, value: self.value!).description
            } else {
                return nil
            }
        }
    }
}
