//
//  AddNavigationView.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/13/20.
//

import Foundation
import TFData

public enum AddNavigationView {
    case form
    
    public func shouldHideNavigationBar() -> Bool {
        switch self {
        default:
            return false
        }
    }
}

extension AddNavigationView: Equatable {
    
    public static func == (lhs: AddNavigationView, rhs: AddNavigationView) -> Bool {
        switch (lhs, rhs) {
        case (.form, .form):
            return true
        }
    }
}
