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
    
    private let repository: OnbanRepository
    private let disposeBag = DisposeBag()
    
    let title: String
    let events: [EventBadge]?
    let detailHash: String
    private(set) var body: String = ""
    private(set) var originPrice: Int?
    private(set) var reducedPrice: Int = 0
    private(set) var savedMoney: Int = 0
    private(set) var deliveryInfo: String = ""
    private(set) var deliveryCharge: String = ""
    private(set) var bannerImages: [URL] = []
    private(set) var exampleImages: [URL] = []
    
    init(productInfo: Dish, repository: OnbanRepository) {
        self.repository = repository
        self.title = productInfo.title
        self.events = productInfo.eventBadge
        self.detailHash = productInfo.detailHash
        bind()
    }
    
    struct Action {
        let requestPayment = PublishRelay<ItemTotalPriceAndAmount>()
        let loadDetail = PublishRelay<Void>()
    }
    
    struct State {
        let readyViewModel = PublishRelay<Void>()
        let successPayment = PublishRelay<Void>()
    }
    
    let action = Action()
    let state = State()
    
    private func bind() {
        action.loadDetail
            .map { self.detailHash }
            .bind(onNext: requestDetail)
            .disposed(by: disposeBag)
        
        action.requestPayment
            .bind(onNext: requestPayment)
            .disposed(by: disposeBag)
    }
    
    private func requestDetail(_ hash: String) {
        Task {
            let receive = try await repository.requestDetail(hash)
            if receive.error != nil { return }
            if let dto = receive.value {
                let detail = dto.convertToEntity()
                setup(with: detail)
                
                self.state.readyViewModel.accept(())
            }
        }
    }
    
    private func requestPayment(_ item: ItemTotalPriceAndAmount) {
        Task {
            let receive = try await repository.requestPayment(item)
            if receive.error != nil { return }
            if receive.value == true {
                state.successPayment.accept(())
            }
        }
    }
    
    private func setup(with object: DetailDish) {
        self.body = object.body
        self.reducedPrice = object.reducedPrice
        self.originPrice = object.originPrice ?? nil
        self.deliveryInfo = object.deliveryInfo
        self.deliveryCharge = object.deliveryFee
        self.savedMoney = object.point
        self.bannerImages = object.thumbImages.compactMap { URL(string: $0) }
        self.exampleImages = object.detailImages.compactMap { URL(string: $0) }
    }
}
