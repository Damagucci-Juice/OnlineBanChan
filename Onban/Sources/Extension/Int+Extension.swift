//
//  Int+Extension.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/15.
//

import Foundation

extension Int {
    var asPriceString: String {
        let stringArray = Array(String(self))
        var reversedResult: String = ""
        var count = 0
        stringArray.reversed().forEach { element in
            if count == 3 {
                reversedResult += ","
                count = 0
            }
            reversedResult += String(element)
            count += 1
        }
        let result = reversedResult.reversed() + "원"
        return result
    }
}
