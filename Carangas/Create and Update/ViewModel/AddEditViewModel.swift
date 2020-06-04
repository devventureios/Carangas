//
//  AddEditViewModel.swift
//  Carangas
//
//  Created by Eric Alves Brito on 03/06/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import Foundation

protocol AddEditViewModelDelegate: class {
    func onBrandsLoaded(result: Result<Bool,Error>)
    func onCarCreated(result: Result<Bool,APIError>)
    func onCarUpdate(result: Result<Bool,APIError>)
}


class AddEditViewModel {
    
    var car: Car
    var brands: [String] = []
    weak var delegate: AddEditViewModelDelegate?
    
    init(car: Car? = nil) {
        self.car = car ?? Car()
    }
    
    var price: String {
        return Formatter.currencyFormatter.string(from: NSNumber(value: car.price)) ?? "R$ \(car.price)"
    }
    
    var title: String {
        return car._id == nil ? "Cadastro" : "Edição"
    }
    
    var buttonTitle: String {
        return car._id == nil ? "Cadastrar carro" : "Editar carro"
    }
    
    var brand: String {
        return car.brand
    }
    
    var name: String {
        return car.name
    }
    
    var gasType: Int {
        return car.gasType
    }
    
    var brandsCount: Int {
        return brands.count
    }
    
    func getBrandAt(_ row: Int) -> String {
        return brands[row]
    }
    
    func refreshCar(name: String, brand: String, gasType: Int, price: String) {
        car.name = name
        car.brand = brand
        car.gasType = gasType
        car.price = Formatter.currencyFormatter.number(from: price)?.doubleValue ?? 0
        
        if car._id == nil {
            CarAPI.createCar(car) { [weak self] (result) in
                guard let self = self else {return}
                self.delegate?.onCarCreated(result: result)
            }
        } else {
            CarAPI.updateCar(car) { [weak self] (result) in
                guard let self = self else {return}
                self.delegate?.onCarUpdate(result: result)
            }
        }
    }
    
    func loadBrands() {
        CarAPI.loadBrands { [weak self] (result) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let brands):
                    self.brands = brands
                    self.delegate?.onBrandsLoaded(result: .success(true))
                case .failure(let error):
                    self.delegate?.onBrandsLoaded(result: .failure(error))
                }
            }
        }
    }
    
}
