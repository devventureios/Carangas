//
//  Alert.swift
//  Carangas
//
//  Created by Eric Alves Brito on 30/05/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

class Alert {
    static func show(title: String?, message: String?, presenter: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        presenter.present(alert, animated: true, completion: nil)
    }
}
