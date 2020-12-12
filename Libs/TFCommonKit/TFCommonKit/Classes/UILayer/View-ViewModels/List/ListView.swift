//
//  ListView.swift
//  TFCommonKit
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import Foundation
import TFData

public enum ListView {
    
    case loading
    case showingData
    case failure(error: ErrorMessage)
}

extension ListView: Equatable {
    
    public static func == (lhs: ListView, rhs: ListView) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading),
             (.showingData, .showingData):
            return true
        default:
            return false
        }
    }
}
