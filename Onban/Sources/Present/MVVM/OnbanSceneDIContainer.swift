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
        func makeMainViewController(actions: MainViewModelAction) -> MainViewController {
            let vc = MainViewController()
            vc.viewModel = MainViewModel(action: actions)
            return vc
        }
    
        func makeDetailViewController(_ dish: Dish) -> DetailViewController {
            let detailViewModel = DetailViewModel(productInfo: dish)
            let vc = DetailViewController()
            vc.viewModel = detailViewModel
            return vc
        }
}
