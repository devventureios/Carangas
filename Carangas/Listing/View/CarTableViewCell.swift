//
//  CarTableViewCell.swift
//  Carangas
//
//  Created by Eric Alves Brito on 02/06/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    func configure(with viewModel: CarCellViewModel) {
        textLabel?.text = viewModel.name
        detailTextLabel?.text = viewModel.brand
    }

}

