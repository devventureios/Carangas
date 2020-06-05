//
//  UIStoryboard+Names.swift
//  Carangas
//
//  Created by Eric Alves Brito on 04/06/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static var listing: UIStoryboard {
        return UIStoryboard(name: "Listing", bundle: nil)
    }
    static var visualization: UIStoryboard {
        return UIStoryboard(name: "Visualization", bundle: nil)
    }
    static var createUpdate: UIStoryboard {
        return UIStoryboard(name: "CreateUpdate", bundle: nil)
    }
}
