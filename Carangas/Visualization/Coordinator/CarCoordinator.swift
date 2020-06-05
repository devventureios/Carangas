//
//  CarCoordinator.swift
//  Carangas
//
//  Created by Eric Alves Brito on 04/06/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

class CarCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var car: Car
    
    init(navigationController: UINavigationController, car: Car) {
        self.navigationController = navigationController
        self.car = car
    }
    
    func start() {
        let viewController = CarViewController.instantiateFromStoryboard(.visualization)
        viewController.coordinator = self
        viewController.viewModel = CarViewModel(car: car)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("CarCoordinator deinit")
    }
    
}
