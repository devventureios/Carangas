//
//  AppCoordinator.swift
//  Carangas
//
//  Created by Eric Alves Brito on 04/06/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    init() {
        navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {
        let childCoordinator = CarsCoordinator(navigationController: navigationController)
//        let childCoordinator = ListForBuyCoordinator(navigationController: navigationController)
        childCoordinator.parentCoordinator = self
        add(childCoordinator: childCoordinator)
        childCoordinator.start()
    }
    
    func showModal(coordinator: Coordinator) {
        navigationController.present(coordinator.navigationController, animated: true, completion: nil)
    }
    
    
}
