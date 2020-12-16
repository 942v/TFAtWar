//
//  UIViewController+TFiOSKit.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import UIKit

public enum Storyboard: String {
    case listStoryboard = "List"
    case addStoryboard = "Add"
    case battelfieldStoryboard = "Battlefield"
}

public extension UIViewController {
    class func instantiate(from storyboard: Storyboard, framework: String? = nil) -> Self {
        return instantiate(from: storyboard.rawValue, framework: framework)
    }
}
