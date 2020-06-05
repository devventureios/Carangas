//
//  CarsTableViewController.swift
//  Carangas
//
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

protocol CarPresentable: class {
    func showCar(_ car: Car)
}
protocol CarCreationEnabled {
    func createCar()
}

typealias CarEnable = CarPresentable & CarCreationEnabled

class CarsTableViewController: UITableViewController {
    
    lazy var viewModel = CarsListingViewModel()
    weak var coordinator: CarEnable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.carsLoaded = carsLoaded
        refreshControl?.addTarget(self, action: #selector(loadCars), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCars()
    }
    
    func carsLoaded() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    @objc func loadCars() {
        viewModel.loadCars()
    }
    
    // MARK: - IBActions
    @IBAction func createCar(_ sender: UIBarButtonItem) {
        coordinator?.createCar()
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CarTableViewCell
        cell.configure(with: viewModel.cellViewModelFor(indexPath: indexPath))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let car = viewModel.getCar(at: indexPath)
        coordinator?.showCar(car)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteCar(at: indexPath) { (result) in
                switch result {
                case .success:
                    break
                case .failure:
                    Alert.show(title: "Erro", message: "Não foi possível excluir o carro", presenter: self)
                }
            }
        }
    }
}
