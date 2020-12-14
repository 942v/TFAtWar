//
//  TransformersDataStoreProtocol.swift
//  TFData
//
//  Created by Guillermo Sáenz on 12/12/20.
//

import Foundation
import PromiseKit

public protocol TransformersDataStoreProtocol {
    func storedToken() -> Promise<String>
    func store(token: String) -> Promise<String>
}
