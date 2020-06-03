//
//  CarCellViewModel.swift
//  Carangas
//
//  Created by Eric Alves Brito on 02/06/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import Foundation

struct CarCellViewModel {
    
    private var car: Car
    
    init(car: Car) {
        self.car = car
    }
    
    var name: String {
        car.name
    }
    
    var brand: String {
        car.brand
    }
    
}
