//
//  UIAlertController+.swift
//  StoreApp
//
//  Created by CHOMINJI on 2020/01/15.
//  Copyright © 2020 cmindy. All rights reserved.
//

import UIKit

extension UIAlertController {
    func addActions(_ actions: [UIAlertAction]) {
        actions.forEach(addAction)
    }
}
