//
//  AddEditViewModel.swift
//  Carangas
//
//  Created by Eric Alves Brito on 03/06/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import Foundation

class AddEditViewModel {
    
    var car: Car
    
    init(car: Car? = nil) {
        self.car = car ?? Car()
    }
    
}
