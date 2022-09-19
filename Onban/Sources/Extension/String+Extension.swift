//
//  String+Extension.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/16.
//

import Foundation

extension String {
    var asPriceInt: Int {
        let numArray = Array(self)
            .map { String($0) }
            .compactMap { Int($0) }
        
        let resultArray = numArray.reversed().enumerated().map { (index, value) in

            let multiplying = (pow(10, index) as NSDecimalNumber).intValue
            return multiplying * value
        }
        
        return resultArray.reduce(0) { $0 + $1 }
    }
}
