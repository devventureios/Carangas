//
//  CarViewController.swift
//  Carangas
//
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

class CarViewController: UIViewController {
    
    @IBOutlet weak var lbBrand: UILabel!
    @IBOutlet weak var lbGasType: UILabel!
    @IBOutlet weak var lbPrice: UILabel!

    var car: Car?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let car = car {
            title = car.name
            lbBrand.text = car.brand
            lbGasType.text = car.gas
            lbPrice.text = car.formattedPrice
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addEditViewController = segue.destination as? AddEditViewController {
            addEditViewController.car = car
        }
    }
}
