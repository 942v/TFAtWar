//
//  UIAlertController+TFiOSKit.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/13/20.
//

import UIKit

extension UIAlertController {
    
    class func errorAlert(title: String, message: String?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(doneAction)
        
        return alertController
    }
}
