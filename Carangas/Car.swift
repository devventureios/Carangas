//
//  Car.swift
//  Carangas
//
//  Created by Eric Alves Brito on 29/05/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import Foundation

class Car: Codable {
    
    var _id: String?
    var brand: String
    var gasType: Int
    var name: String
    var price: Int
    
    var gas: String {
        switch gasType {
        case 0:
            return "Flex"
        case 1:
            return "Álcool"
        default:
            return "Gasolina"
        }
    }
}
