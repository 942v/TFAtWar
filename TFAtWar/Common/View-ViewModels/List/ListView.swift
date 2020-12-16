//
//  ListView.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import Foundation

public enum ListView {
    
    case loading
    case showingData
    case deleting
    case failure(error: ErrorMessage)
}

extension ListView: Equatable {
    
    public static func == (lhs: ListView, rhs: ListView) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading),
             (.showingData, .showingData),
             (.deleting, .deleting):
            return true
        default:
            return false
        }
    }
}
