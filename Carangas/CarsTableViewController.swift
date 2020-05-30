//
//  CarsTableViewController.swift
//  Carangas
//
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

class CarsTableViewController: UITableViewController {

    var cars: [Car] = []
    var loading = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl?.addTarget(self, action: #selector(loadCars), for: .valueChanged)
        
        /*
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.style = .whiteLarge
        loading.tintColor = .systemGreen
        loading.color = .systemGreen
        loading.frame.origin = CGPoint(x: 250, y: 300)
        loading.hidesWhenStopped = true
        view.addSubview(loading)
        loading.startAnimating()
        */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCars()
    }
    
    @objc func loadCars() {
        CarAPI.loadCars { [weak self] (result) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
                self.loading.stopAnimating()
            }
            switch result {
            case .success(let cars):
                self.cars = cars
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let apiError):
                print(apiError)
            }
        }
        
        //GEITU VIDA LOKA
        /*
        URLSession.shared.dataTask(with: URL(string: "https://carangas.herokuapp.com/cars")!) { data,_,_ in
            self.cars = try! JSONDecoder().decode([Car].self, from: data!)
            DispatchQueue.main.async {self.tableView.reloadData()}
        }.resume()
        */
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let car = cars[indexPath.row]
        cell.textLabel?.text = car.name
        cell.detailTextLabel?.text = car.brand
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let car = cars[indexPath.row]
            CarAPI.deleteCar(car) { [weak self] (result) in
                guard let self = self else {return}
                switch result {
                case .success:
                    self.cars.remove(at: indexPath.row)
                    DispatchQueue.main.async {
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                    }
                case .failure:
                    Alert.show(title: "Erro", message: "Não foi possível excluir o carro", presenter: self)
                }
            }
        }
    }
}
