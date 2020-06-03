//
//  Formatter.swift
//  Carangas
//
//  Created by Eric Alves Brito on 03/06/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import Foundation

class Formatter {
    static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter
    }()
}
