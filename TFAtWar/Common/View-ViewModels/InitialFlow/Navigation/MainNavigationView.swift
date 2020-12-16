//
//  MainNavigationView.swift
//  TFiOSKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import Foundation

public enum MainNavigationView {
    case list
    case add(transformer: TransformerData?)
    
    public func shouldHideNavigationBar() -> Bool {
        switch self {
        default:
            return false
        }
    }
}

extension MainNavigationView: Equatable {
    
    public static func == (lhs: MainNavigationView, rhs: MainNavigationView) -> Bool {
        switch (lhs, rhs) {
        case (.list, .list),
             (.add(transformer:), .add(transformer:)):
            return true
        default:
            return false
        }
    }
}
