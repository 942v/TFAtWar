//
//  TransformersUserDefaultsDataStore.swift
//  TFData
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import Foundation
import PromiseKit

fileprivate enum StorageKeys: String {
    case token
}

public class TransformersUserDefaultsDataStore {
    private let userDefaults = UserDefaults.standard
    
    public init() {}
}

extension TransformersUserDefaultsDataStore: TransformersDataStoreProtocol {
    public func storedToken() -> Promise<String> {
        return Promise<String> { seal in
            let token = userDefaults.string(forKey: StorageKeys.token.rawValue)
            
            guard let authenticationToken = token else {
                let error = FetchDataError.existence
                seal.reject(error)
                return
            }
            
            seal.fulfill(authenticationToken)
        }
    }
    
    public func store(token: String) -> Promise<String> {
        return Promise<String> { seal in
            userDefaults.setValue(token, forKey: StorageKeys.token.rawValue)
            
            seal.fulfill(token)
        }
    }
}
