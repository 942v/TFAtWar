//
//  BattlefieldView.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/14/20.
//

import Foundation
import TFData

public enum BattlefieldView {
    
    case idle
    case result(_ info: String)
}

extension BattlefieldView: Equatable {
    
    public static func == (lhs: BattlefieldView, rhs: BattlefieldView) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle),
             (.result(_), .result(_)):
            return true
        default:
            return false
        }
    }
}
