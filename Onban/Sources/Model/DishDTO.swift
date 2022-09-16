//
//  DishDTO.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/08.
//

import Foundation

struct DishDTO: Codable {
    let detailHash: String
    let image: String
    let alt: String
    let deliveryType: [DeliveryType]
    let title, bodyDescription: String
    let originPrice: String?
    let reducedPrice: String
    let eventBadge: [EventBadge]?

    enum CodingKeys: String, CodingKey {
        case detailHash = "detail_hash"
        case image, alt
        case deliveryType = "delivery_type"
        case title
        case bodyDescription = "description"
        case originPrice = "n_price"
        case reducedPrice = "s_price"
        case eventBadge = "badge"
    }
    
    func convertToEntity() -> MainProductEntity {
        guard let url = URL(string: self.image) else {
            assert(false)
        }
        
        return MainProductEntity(
            detailHash: self.detailHash,
            imageAddress: url,
            deliveryType: self.deliveryType,
            title: self.title,
            body: self.bodyDescription,
            originPrice: self.originPrice,
            reducedPrice: self.reducedPrice,
            eventBadge: self.eventBadge
        )
    }
}

enum DeliveryType: String, Codable {
    case earlyDelivery = "새벽배송"
    case nationalPost = "전국택배"
}

enum EventBadge: String, Codable {
    case luanchingSpecialPrice = "런칭특가"
    case eventSpecialPrice = "이벤트특가"
    case mainSpecialPrice = "메인특가"
}
