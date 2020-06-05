//
//  AddEditCoordinator.swift
//  Carangas
//
//  Created by Eric Alves Brito on 04/06/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

class AddEditCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var car: Car?
    
    init(navigationController: UINavigationController, car: Car? = nil) {
        self.navigationController = navigationController
        self.car = car
    }
    
    func start() {
        let viewController = AddEditViewController.instantiateFromStoryboard(.createUpdate)
        viewController.coordinator = self
        viewController.viewModel = AddEditViewModel(car: car)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("AddEditCoordinator deinit")
    }
    
}
