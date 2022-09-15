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
    private lazy var items: [[DishDTO]?] = Array(repeating: nil, count: 3)
    var countOfSections: Int { return items.count }
    
    subscript(indexPath: IndexPath) -> DishDTO? {
        if isValid(indexPath: indexPath) {
            return items[indexPath.section]?[indexPath.row]
        }
        return nil
    }
    
    struct Action {
        let viewDidLoad = PublishRelay<Void>()
        let touchedCell = PublishRelay<IndexPath>()
    }
    
    struct State {
        let openedDetailPage: () -> Void = { }
        let reloadedSection = PublishRelay<Int>()
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
        [.requestMainDish,
         .requestSoup,
         .requestSideDish].enumerated().forEach(requestMain)
    }
    
    private func requestMain(_ index: Int, _ target: OnbanAPI) {
        Task {
            let receive = try await self.repository.requestViewModel(target)
            if receive.error != nil { return }
            self.items[index] = receive.value ?? []
            self.state.reloadedSection.accept(index)
        }
    }
}

extension MainViewModel {
    private func isValid(indexPath: IndexPath) -> Bool {
        let section = indexPath.section
        let row = indexPath.row
        if items.count > section && items[section]?.count ?? 0 > row {
            return true
        }
        return false
    }
    
    func getItemCount(of section: Int) -> Int {
        return items[section]?.count ?? 0
    }
}
