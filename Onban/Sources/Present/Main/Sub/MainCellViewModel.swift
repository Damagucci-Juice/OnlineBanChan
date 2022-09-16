//
//  MainCellViewModel.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/15.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa


final class MainCellViewModel: ViewModel {
    
    private(set) var entity: Dish
    private let disposeBag = DisposeBag()
    
    struct Action {
        let loadCell = PublishRelay<Void>()
        var showDetailDish: (Dish) -> Void = { _ in }
    }
    
    struct State {
        let entityReady = PublishRelay<Dish>()
    }
    
    var action = Action()
    var state = State()
    
    init(_ dish: DishDTO) {
        self.entity = dish.convertToEntity()
        bind()
    }
    
    private func bind() {
        action.loadCell
            .map { self.entity }
            .bind(to: state.entityReady)
            .disposed(by: disposeBag)
    }
}
