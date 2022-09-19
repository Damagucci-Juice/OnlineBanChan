//
//  CategoryType.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/15.
//

import Foundation

enum CategoryType: Int, CaseIterable {
    case main
    case soup
    case side
    
    var api: OnbanAPI {
        switch self {
        case .main:
            return .requestMainDish
        case .soup:
            return .requestSoup
        case .side:
            return .requestSideDish
        }
    }
    
    var index: Int { self.rawValue }
}
