//
//  RemoteAPIError.swift
//  TFData
//
//  Created by Guillermo Sáenz on 12/11/20.
//

import Foundation

public enum RemoteAPIError: Error {
    case unknown
    case createURL
    case httpError
    case needAuthentication
    case dataValidation
    
    var localizedDescription: String {
        return description
    }
}

extension RemoteAPIError: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .createURL:
            return "There was an error creating the URL"
        case .httpError:
            return "There was an error loading some data"
        case .unknown:
            return "An unknown error happen, try again"
        case .needAuthentication:
            return "You need to authenticate first"
        case .dataValidation:
            return "Invalid values"
        }
    }
}

extension RemoteAPIError: LocalizedError {
    public var errorDescription: String? {
        description
    }
}
