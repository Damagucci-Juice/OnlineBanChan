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
    
    // MARK: - 뷰 모델은 무엇을 해야하는가?
    private let repository: OnbanRepository = OnbanRepositoryImpl()
    lazy var data: [[DishDTO]] = []
    
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
            let side = try await self.repository.reqeuestSide()
            let soup = try await self.repository.reqeuestSoup()
            if main.error != nil,
               side.error != nil,
               soup.error != nil {
                return
            }
            guard let mainModel = main.value,
                  let sideModel = side.value,
                  let soupModel = soup.value else {
                      return
                  }
            let mainViewModel: [[DishDTO]] = [mainModel, soupModel, sideModel]
            self.data = mainViewModel
            
            self.state.reloadData.accept(())
        }
    }
}
