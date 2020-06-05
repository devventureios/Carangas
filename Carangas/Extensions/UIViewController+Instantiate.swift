//
//  UIViewController+Instantiate.swift
//  Carangas
//
//  Created by Eric Alves Brito on 04/06/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

extension UIViewController {
    static func instantiateFromStoryboard(_ storyboard: UIStoryboard) -> Self {
        let name = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: name) as! Self
    }
}
