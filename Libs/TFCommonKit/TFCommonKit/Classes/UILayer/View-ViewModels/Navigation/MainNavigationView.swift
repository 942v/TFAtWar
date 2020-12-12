//
//  MainNavigationView.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import Foundation

public enum MainNavigationView {
    case list
    case add
    
    public func shouldHideNavigationBar() -> Bool {
        switch self {
        default:
            return false
        }
    }
}
