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
    private(set) var bannerImages: [String] = []
    private(set) var exampleImages: [String] = []
    
    init(productInfo: Dish, repository: OnbanRepository) {
        self.repository = repository
        self.title = productInfo.title
        self.events = productInfo.eventBadge
        self.detailHash = productInfo.detailHash
        bind()
    }
    
    struct Action {
        let requestPayment = PublishRelay<Void>()
        let loadDetail = PublishRelay<Void>()
    }
    
    struct State {
        let readyViewModel = PublishRelay<Void>()
    }
    
    let action = Action()
    let state = State()
    
    // TODO: - requestDetail 이 완료되면 state.readyViewModel 로 값을 보낼 수 있는 방법 조사
    private func bind() {
        action.loadDetail
            .map { self.detailHash }
            .bind(onNext: requestDetail)
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
    
    private func setup(with object: DetailDish) {
        self.body = object.body
        self.reducedPrice = object.reducedPrice
        self.originPrice = object.originPrice ?? 0
        self.deliveryInfo = object.deliveryInfo
        self.deliveryCharge = object.deliveryFee
        self.bannerImages = object.thumbImages
        self.exampleImages = object.detailImages
        self.savedMoney = object.point
    }
}
