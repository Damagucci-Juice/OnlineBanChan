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
    private lazy var items: [[DishDTO]] = []
    var countOfSections: Int { return items.count }
    
    subscript(indexPath: IndexPath) -> DishDTO? {
        if isValid(indexPath: indexPath) {
            return items[indexPath.section][indexPath.row]
        }
        return nil
    }
    
    struct Action {
        let viewDidLoad = PublishRelay<Void>()
        let touchedCell = PublishRelay<IndexPath>()
    }
    
    struct State {
        let openedDetailPage: () -> Void = { }
        let reloadData = PublishRelay<Void>()
    }
    
    let action = Action()
    let state = State()
    private let disposeBag = DisposeBag()
    
    init() {
        action.viewDidLoad
            .bind(onNext: requestMain)
            .disposed(by: disposeBag)
    }
}

extension MainViewModel {
    
    func requestMain() {
        Task {
            let main = try await self.repository.reqeuestMain()
            if main.error != nil { return }
            guard let mainModel = main.value else { return }
            let mainViewModel: [[DishDTO]] = mainModel
            self.items = mainViewModel
            self.state.reloadData.accept(())
        }
    }
}

extension MainViewModel {
    private func isValid(indexPath: IndexPath) -> Bool {
        let section = indexPath.section
        let row = indexPath.row
        if items.count > section && items[section].count > row {
            return true
        }
        return false
    }
    
    func getItemCount(of section: Int) -> Int {
        return items[section].count
    }
}
