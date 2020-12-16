//
//  BattlefieldNavigationView.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/14/20.
//

import Foundation

public enum BattlefieldNavigationView {
    case battlefield
    
    public func shouldHideNavigationBar() -> Bool {
        switch self {
        default:
            return false
        }
    }
}

extension BattlefieldNavigationView: Equatable {
    
    public static func == (lhs: BattlefieldNavigationView, rhs: BattlefieldNavigationView) -> Bool {
        switch (lhs, rhs) {
        case (.battlefield, .battlefield):
            return true
        }
    }
}
