//
//  Optional+Valid.swift
//  Carangas
//
//  Created by Eric Alves Brito on 30/05/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    var 🧨: String {
        switch self {
        case .some(let value):
            return value
        case .none:
            return ""
        }
    }
}

extension Optional where Wrapped == Int {
    var 🧨: Int {
        switch self {
        case .some(let value):
            return value
        case .none:
            return 0
        }
    }
}

extension Optional where Wrapped == Bool {
    var 🧨: Bool {
        switch self {
        case .some(let value):
            return value
        case .none:
            return false
        }
    }
}
