//
//  MainViewModel.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/12.
//

import Foundation
import RxCocoa
import RxSwift

struct MainViewModelAction {
    let viewDidLoad = PublishRelay<Void>()
    var showDetail: (Dish) -> Void
}

final class MainViewModel: ViewModel {
    
    private let repository: OnbanRepository
    
    struct State {
        let items = PublishRelay<(CategoryType, [MainCellViewModel])>()
    }
    
    let action: MainViewModelAction
    let state = State()
    
    private let disposeBag = DisposeBag()
    
    init(action: MainViewModelAction, repository: OnbanRepository) {
        self.action = action
        self.repository = repository
        bind()
    }
}

extension MainViewModel {
    
    func loadItems() {
        CategoryType.allCases.enumerated().forEach(requestMain)
    }
    
    private func requestMain(_ index: Int, _ categoryType: CategoryType) {
        Task { [unowned self] in
            let receive = try await self.repository.requestItems(categoryType)
            if receive.error != nil { return }
            let item = (receive.value ?? []).map { MainCellViewModel($0) }
            self.state.items.accept((categoryType, item))
        }
    }
    
    private func bind() {
        action.viewDidLoad
            .bind(onNext: loadItems)
            .disposed(by: disposeBag)
    }
}
