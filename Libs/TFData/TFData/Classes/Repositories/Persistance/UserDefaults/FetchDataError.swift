//
//  FetchDataError.swift
//  TFData
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import Foundation

public enum FetchDataError: Error {
    case unknown
    case existence
}

extension FetchDataError: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .unknown:
            return "An unknown error happen, try again"
        case .existence:
            return "Token is not stored"
        }
    }
}
