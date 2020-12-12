//
//  TransformersDataRepository.swift
//  TFData
//
//  Created by Guillermo Sáenz on 12/11/20.
//

import Foundation
import PromiseKit

// The idea of this class is to be the only gateway to access data, it can be via a local data store or fetching from API
public class TransformersDataRepository {
    
    let transformersDataRemoteAPI: TransformersDataRemoteAPIProtocol
    
    public init(transformersDataRemoteAPI: TransformersDataRemoteAPIProtocol) {
        self.transformersDataRemoteAPI = transformersDataRemoteAPI
        // Here we could inject a data store like core data or use UserDefaults to store the downloaded data.
    }
}

extension TransformersDataRepository: TransformersDataRepositoryProtocol {
    public func create(_ request: TransformerRequest) -> Promise<TransformerData> {
        
        return Promise<TransformerData> { seal in
            firstly {
                setAuthenticationToken()
            }.then {
                self.transformersDataRemoteAPI.create(request)
            }.done {
                seal.fulfill($0)
            }.catch {
                seal.reject($0)
            }
        }
    }
    
    public func getTransformers() -> Promise<[TransformerData]> {
        return Promise<[TransformerData]> { seal in
            firstly {
                setAuthenticationToken()
            }.then {
                self.transformersDataRemoteAPI.getTransformers()
            }.done {
                seal.fulfill($0)
            }.catch {
                seal.reject($0)
            }
        }
    }
    
    public func change(_ request: TransformerRequest) -> Promise<TransformerData> {
        return Promise<TransformerData> { seal in
            firstly {
                setAuthenticationToken()
            }.then {
                self.transformersDataRemoteAPI.change(request)
            }.done {
                seal.fulfill($0)
            }.catch {
                seal.reject($0)
            }
        }
    }
    
    public func delete(_ id: String) -> Promise<Void> {
        return Promise<Void> { seal in
            firstly {
                setAuthenticationToken()
            }.then {
                self.transformersDataRemoteAPI.delete(id)
            }.done {
                seal.fulfill($0)
            }.catch {
                seal.reject($0)
            }
        }
    }
}

private extension TransformersDataRepository {
    
    func setAuthenticationToken() -> Promise <Void> {
        return Promise <Void> { seal in
            if transformersDataRemoteAPI.hasToken() {
                seal.fulfill_()
            }else{
                firstly {
                    transformersDataRemoteAPI.getAuthorizationToken()
                }.done {
                    self.transformersDataRemoteAPI.set(authorizationToken: $0)
                    seal.fulfill_()
                }.catch {
                    seal.reject($0)
                }
            }
        }
    }
}
