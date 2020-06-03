//
//  CarsListingViewModel.swift
//  Carangas
//
//  Created by Eric Alves Brito on 02/06/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import Foundation

class CarsListingViewModel {
    
    private var cars: [Car] = [] {
        didSet {
            carsLoaded?()
        }
    }
    
    var carsLoaded: (()->Void)?
    
    var count: Int {
        return cars.count
    }
    
    func loadCars() {
        CarAPI.loadCars { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let cars):
                self.cars = cars
            case .failure:
                self.carsLoaded?()
            }
        }
    }
    
    func getCar(at indexPath: IndexPath) -> Car {
        return cars[indexPath.row]
    }
    
    func cellViewModelFor(indexPath: IndexPath) -> CarCellViewModel {
        let car = getCar(at: indexPath)
        return CarCellViewModel(car: car)
    }
    
    func deleteCar(at indexPath: IndexPath, onComplete: @escaping (Result<Bool, APIError>)->Void) {
        let car = getCar(at: indexPath)
        CarAPI.deleteCar(car) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success:
                self.cars.remove(at: indexPath.row)
            case .failure:
                break
            }
            onComplete(result)
        }
    }
}
