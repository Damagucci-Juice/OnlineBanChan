//
//  OnbanFlowCoordinator.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/16.
//

import UIKit

final class OnbanFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: OnbanFlowCoordinatorDependencies
    
    private weak var mainVC: MainViewController?
    
    init(navigationController: UINavigationController,
         dependencies: OnbanFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = MainViewModelAction(showDetail: showDishDetail)
        let vc = dependencies.makeMainViewController(actions: actions)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    private func showDishDetail(dish: Dish) {
        let vc = dependencies.makeDetailViewController(dish)
        navigationController?.pushViewController(vc, animated: true)
    }
}
