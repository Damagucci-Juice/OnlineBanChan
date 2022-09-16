//
//  MainCellViewModel.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/15.
//

import Foundation
import RxSwift
import RxRelay

final class MainCellViewModel: ViewModel {
    
    private let entity: MainProductEntity
    private let disposeBag = DisposeBag()
    
    struct Action {
        let cellDidLoad = PublishRelay<Void>()
    }
    
    struct State {
        let entityReady = PublishRelay<MainProductEntity>()
    }
    
    let action: Action = Action()
    let state: State = State()
    
    init(_ dish: DishDTO) {
        self.entity = dish.convertToEntity()
        bind()
    }
    
    private func bind() {
        self.action.cellDidLoad
            .map { self.entity }
            .bind(to: state.entityReady)
            .disposed(by: disposeBag)
    }
}
