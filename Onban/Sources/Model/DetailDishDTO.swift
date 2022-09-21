//
//  DetailDishDTO.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/16.
//

import Foundation

struct DetailResponse: Codable {
    let hash: String
    let data: DetailDishDTO
}

// MARK: - DataClass
struct DetailDishDTO: Codable {
    let topImage: String
    let thumbImages: [String]
    let productDescription, point, deliveryInfo, deliveryFee: String
    let prices: [String]
    let detailSection: [String]

    enum CodingKeys: String, CodingKey {
        case topImage = "top_image"
        case thumbImages = "thumb_images"
        case productDescription = "product_description"
        case point
        case deliveryInfo = "delivery_info"
        case deliveryFee = "delivery_fee"
        case prices
        case detailSection = "detail_section"
    }
    
    func convertToEntity() -> DetailDish {
        var detailDish = DetailDish(
            title: nil,
            body: self.productDescription,
            thumbImages: self.thumbImages,
            detailImages: self.detailSection,
            point: self.point.asPriceInt,
            deliveryInfo: self.deliveryInfo,
            deliveryFee: self.deliveryFee,
            reducedPrice: self.prices[0].asPriceInt
        )
        if self.prices.count == 2 {
            detailDish.originPrice = self.prices[0].asPriceInt
            detailDish.reducedPrice = self.prices[1].asPriceInt
        }
        return detailDish
    }
}
