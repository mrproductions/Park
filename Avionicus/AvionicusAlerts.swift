//
//  AlertManager.swift
//  Avionicus
//
//  Created by Фамил Гаджиев on 12.04.17.
//  Copyright © 2017 Park Team. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    static func errorAlert (title: String?, message: String?, buttonTitle: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .cancel, handler: nil)
        alert.addAction(action)
        return alert
        
    }
    
}
