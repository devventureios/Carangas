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
        if let carViewController = segue.destination as? CarViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            carViewController.car = viewModel.getCar(at: indexPath)
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
