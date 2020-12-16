//
//  TransformersDataRemoteAPIProtocol.swift
//  TFData
//
//  Created by Guillermo Sáenz on 12/11/20.
//

import Foundation
import PromiseKit

public protocol TransformersDataRemoteAPIProtocol {
    
    func hasToken() -> Bool
    func set(authorizationToken : String)
    
    func getAuthorizationToken() -> Promise<String>
    func create(_ request: TransformerRequest) -> Promise<TransformerData>
    func getTransformers() -> Promise<[TransformerData]>
    func change(_ request: TransformerRequest) -> Promise<TransformerData>
    func delete(_ id: String) -> Promise<Void>
}
