//
//  CategoryDTO.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/08.
//

import Foundation

struct CategoryDTO: Codable {
    let statusCode: Int
    let body: [DishDTO]
}
