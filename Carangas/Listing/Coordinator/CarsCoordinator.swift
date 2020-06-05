//
//  CarsCoordinator.swift
//  Carangas
//
//  Created by Eric Alves Brito on 04/06/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

class CarsCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = CarsTableViewController.instantiateFromStoryboard(.listing)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension CarsCoordinator: CarEnable {
    func showCar(_ car: Car) {
        let childCoordinator = CarCoordinator(navigationController: navigationController, car: car)
        childCoordinator.parentCoordinator = self
        add(childCoordinator: childCoordinator)
        childCoordinator.start()
    }
    func createCar() {
        let childCoordinator = AddEditCoordinator(navigationController: navigationController)
        childCoordinator.parentCoordinator = self
        add(childCoordinator: childCoordinator)
        childCoordinator.start()
    }
}

