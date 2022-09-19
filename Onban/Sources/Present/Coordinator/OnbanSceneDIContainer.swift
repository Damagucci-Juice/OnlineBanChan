//
//  OnbanFlowDependency.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/16.
//

import UIKit

protocol OnbanFlowCoordinatorDependencies {
    func makeMainViewController(actions: MainViewModelAction) -> MainViewController
    func makeDetailViewController(_ dish: Dish) -> DetailViewController
}

final class OnbanSceneDIContainer {
    
    func makeOnbanFlowCoodinator(navigationController: UINavigationController) -> OnbanFlowCoordinator {
        return OnbanFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension OnbanSceneDIContainer: OnbanFlowCoordinatorDependencies {
    
    func makeOnbanRepository() -> OnbanRepository {
        return OnbanRepositoryImpl()
    }
    
    func makeMainViewController(actions: MainViewModelAction) -> MainViewController {
        let vc = MainViewController()
        vc.viewModel = makeMainViewModel(actions: actions)
        return vc
    }
    
    func makeMainViewModel(actions: MainViewModelAction) -> MainViewModel {
        return MainViewModel(action: actions, repository: makeOnbanRepository())
    }
    
    func makeDetailViewController(_ dish: Dish) -> DetailViewController {
        let detailViewModel = makeDetailViewModel(with: dish)
        let vc = DetailViewController()
        vc.viewModel = detailViewModel
        return vc
    }
    
    func makeDetailViewModel(with dish: Dish) -> DetailViewModel {
        return DetailViewModel(productInfo: dish)
    }
}
