//
//  AddView.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import Foundation

public enum AddView {
    
    case loading
    case idle
    case validating
    case failure(error: ErrorMessage)
}

extension AddView: Equatable {
    
    public static func == (lhs: AddView, rhs: AddView) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading),
             (.idle, .idle),
             (.validating, .validating),
             (.failure(_), .failure(_)):
            return true
        default:
            return false
        }
    }
}
