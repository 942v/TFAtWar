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
    case winner
    case failure(error: ErrorMessage)
}

extension BattlefieldView: Equatable {
    
//    public static func == (lhs: BattlefieldView, rhs: BattlefieldView) -> Bool {
//        switch (lhs, rhs) {
//        case (.loading, .loading),
//             (.idle, .idle),
//             (.validating, .validating),
//             (.failure(_), .failure(_)):
//            return true
//        default:
//            return false
//        }
//    }
}
