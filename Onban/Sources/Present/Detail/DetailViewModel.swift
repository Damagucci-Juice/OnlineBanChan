//
//  DetailViewModel.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/13.
//

import Foundation

final class DetailViewModel: ViewModel {
    
    private let productInfo: Dish
    private var detailProduct: DetailDish?
    
    init(productInfo: Dish) {
        self.productInfo = productInfo
    }
    
    struct Action {
        
    }
    
    struct State {
        
    }
    
    let action = Action()
    let state = State()
}
