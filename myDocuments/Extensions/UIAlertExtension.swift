//
//  UIAlertExtension.swift
//  myDocuments
//
//  Created by Pedro Nascimento on 16/04/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    class func simpleAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        return alert
    }
}
