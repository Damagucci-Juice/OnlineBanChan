//
//  MainViewModel.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/12.
//

import Foundation
import RxCocoa
import RxSwift

class MainViewModel: ViewModel {
    
    private let repository: OnbanRepository = OnbanRepositoryImpl()
    
    struct Action {
        let viewDidLoad = PublishRelay<Void>()
        let touchedCell = PublishRelay<IndexPath>()
    }
    
    struct State {
        let items = PublishRelay<(CategoryType, [MainCellViewModel])>()
    }
    
    let action = Action()
    let state = State()
    private let disposeBag = DisposeBag()
    
    init() {
        action.viewDidLoad
            .bind(onNext: loadViewModels)
            .disposed(by: disposeBag)
    }
}

extension MainViewModel {
    
    func loadViewModels() {
        CategoryType.allCases.enumerated().forEach(requestMain)
    }
    
    private func requestMain(_ index: Int, _ categoryType: CategoryType) {
        Task {
            let receive = try await self.repository.requestOnbanApi(categoryType)
            if receive.error != nil { return }
            let item = (receive.value ?? []).map { MainCellViewModel($0) }
            self.state.items.accept((categoryType, item))
        }
    }
}
