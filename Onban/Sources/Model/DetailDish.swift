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
    let detailImages: [String]
    let point: Int
    let deliveryInfo: String
    let deliveryFee: String
    var reducedPrice: Int
    var originPrice: Int?
    
    init(title: String? = nil,
         body: String,
         thumbImages: [String],
         detailImages: [String],
         point: Int,
         deliveryInfo: String,
         deliveryFee: String,
         reducedPrice: Int,
         originPrice: Int? = nil) {
        
        self.title = title
        self.body = body
        self.thumbImages = thumbImages
        self.detailImages = detailImages
        self.point = point
        self.deliveryInfo = deliveryInfo
        self.deliveryFee = deliveryFee
        self.reducedPrice = reducedPrice
        self.originPrice = originPrice
    }
}
