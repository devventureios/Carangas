//
//  CarsTableViewController.swift
//  Carangas
//
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

class CarsTableViewController: UITableViewController {

    lazy var viewModel = CarsListingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.carsLoaded = carsLoaded
        refreshControl?.addTarget(self, action: #selector(loadCars), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCars()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let carViewController as CarViewController:
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let car = viewModel.getCar(at: indexPath)
            carViewController.viewModel = CarViewModel(car: car)
        case let addEditViewController as AddEditViewController:
            addEditViewController.viewModel = AddEditViewModel()
        default:
            break
        }
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
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CarTableViewCell
        cell.configure(with: viewModel.cellViewModelFor(indexPath: indexPath))
        return cell
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
