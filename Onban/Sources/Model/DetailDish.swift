//
//  DetailProduct.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/16.
//

import Foundation

struct DetailDish {
    var title: String?
    let body: String
    let thumbImages: [String]
    let point: Int
    let deliveryInfo: String
    let deliveryFee: String
    let reducedPrice: Int
    let originPrice: Int?
}
