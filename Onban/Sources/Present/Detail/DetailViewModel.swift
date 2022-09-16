//
//  DetailViewModel.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/13.
//

import Foundation
import RxSwift
import RxRelay

final class DetailViewModel: ViewModel {
    
    private let repository = OnbanRepositoryImpl()
    
    private let productInfo: Dish
    private var detailProduct: DetailDish?
    
    init(productInfo: Dish) {
        self.productInfo = productInfo
        requestDetail(productInfo.detailHash)
    }
    
    struct Action {
        let requestPayment = PublishRelay<Void>()
    }
    
    struct State {
        
    }
    
    let action = Action()
    let state = State()
    
    private func bind() {
        
    }
    
    private func requestDetail(_ hash: String) {
        Task {
            let receive = try await repository.requestDetail(hash)
            if receive.error != nil { return }
            if let dto = receive.value {
                var detail = dto.convertToEntity()
                detail.title = productInfo.title
                self.detailProduct = detail
            }
        }
    }
}
