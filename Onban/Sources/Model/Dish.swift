//
//  MainProductEntity.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/16.
//

import Foundation

struct Dish {
    let detailHash: String
    let imageAddress: URL
    let deliveryType: [DeliveryType]
    let title: String
    let body: String
    let originPrice: String?
    let reducedPrice: String
    let eventBadge: [EventBadge]?
}
