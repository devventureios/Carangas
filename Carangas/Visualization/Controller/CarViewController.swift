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

    var viewModel: CarViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let viewModel = viewModel {
            title = viewModel.title
            lbBrand.text = viewModel.brand
            lbGasType.text = viewModel.gasType
            lbPrice.text = viewModel.price
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addEditViewController = segue.destination as? AddEditViewController {
            addEditViewController.viewModel = AddEditViewModel(car: viewModel?.car)
        }
    }
}
