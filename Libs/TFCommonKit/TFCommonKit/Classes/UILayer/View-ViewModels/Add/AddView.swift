//
//  AddView.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import Foundation
import TFData

public enum AddView {
    
    case idle
    case loading
    case failure(error: ErrorMessage)
}

extension AddView: Equatable {
    
    public static func == (lhs: AddView, rhs: AddView) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle),
             (.loading, .loading):
            return true
        default:
            return false
        }
    }
}
