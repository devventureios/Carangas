//
//  CarsTableViewController.swift
//  Carangas
//
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

class CarsTableViewController: UITableViewController {

    var cars: [Car] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCars()
    }
    
    private func loadCars() {
        CarAPI.loadCars { [weak self] (result) in
            guard let self = self else {return}
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
}
