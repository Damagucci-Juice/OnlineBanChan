//
//  ItemTotalPriceAndAmount.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/15.
//

import Foundation

struct ItemTotalPriceAndAmount {
    let price: Int
    private(set) var amount: Int = 1 {
        willSet {
            guard newValue > 0 else { return }
        }
    }
    var totalPirce: String {
        let totalValue = price * amount
        return totalValue.asPrice
    }
    
    mutating func updateAmount(_ value: Double) {
        amount = Int(value)
    }
}
