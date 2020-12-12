//
//  TransformersDataRemoteAPI.swift
//  TFData
//
//  Created by Guillermo Sáenz on 12/11/20.
//

import Foundation
import PromiseKit

let domainURL = "https://transformers-api.firebaseapp.com"

// Implementation of real API
public class TransformersDataRemoteAPI {
    
    let urlSession = URLSession.shared
    
    private(set) var authorizationToken: String?
    
    public init() {}
}

// We conform to the protocol to be able to be inyected
extension TransformersDataRemoteAPI: TransformersDataRemoteAPIProtocol {
    
    public func hasToken() -> Bool {
        authorizationToken != nil
    }
    
    public func set(authorizationToken: String) {
        self.authorizationToken = authorizationToken
    }
    
    public func getAuthorizationToken() -> Promise<String> {
        return Promise<String> { seal in
            
            guard let url = Services.allspark.getURL() else {
                seal.reject(RemoteAPIError.createURL)
                return
            }
            
            let request = getRequest(for: url, verb: .get)
            
            urlSession.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    seal.reject(error)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    seal.reject(RemoteAPIError.unknown)
                    return
                }
                guard 200..<300 ~= httpResponse.statusCode else {
                    seal.reject(RemoteAPIError.httpError)
                    return
                }
                guard let data = data else {
                    seal.reject(RemoteAPIError.unknown)
                    return
                }
                
                guard let token = String(data: data, encoding: .utf8) else {
                    seal.reject(RemoteAPIError.unknown)
                    return
                }
                seal.fulfill(token)
            }.resume()
        }
    }
    
    public func create(_ request: TransformerRequest) -> Promise<TransformerData> {
        
        return Promise<TransformerData> { seal in
            
            guard let _ = authorizationToken else {
                seal.reject(RemoteAPIError.needAuthentication)
                return
            }
            
            guard let url = Services.transformers.getURL() else {
                seal.reject(RemoteAPIError.createURL)
                return
            }
            
            guard let body = try? JSONEncoder().encode(request) else {
                fatalError("Error trying to encode request object")
            }
            
            let request = getRequest(for: url, verb: .post, body: body)
            
            urlSession.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    seal.reject(error)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    seal.reject(RemoteAPIError.unknown)
                    return
                }
                guard 200..<300 ~= httpResponse.statusCode else {
                    guard let _ = data else {
                        seal.reject(RemoteAPIError.httpError)
                        return
                    }
                    // TODO: handle errors with custom description
                    return
                }
                guard let data = data else {
                    seal.reject(RemoteAPIError.unknown)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(TransformerData.self, from: data)
                    seal.fulfill(response)
                } catch let error as NSError {
                    seal.reject(error)
                }
            }.resume()
        }
    }
    
    public func getTransformers() -> Promise<[TransformerData]> {
        
        return Promise<[TransformerData]> { seal in
            
            guard let _ = authorizationToken else {
                seal.reject(RemoteAPIError.needAuthentication)
                return
            }
            
            guard let url = Services.transformers.getURL() else {
                seal.reject(RemoteAPIError.createURL)
                return
            }
            
            let request = getRequest(for: url, verb: .get)
            
            urlSession.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    seal.reject(error)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    seal.reject(RemoteAPIError.unknown)
                    return
                }
                guard 200..<300 ~= httpResponse.statusCode else {
                    guard let _ = data else {
                        seal.reject(RemoteAPIError.httpError)
                        return
                    }
                    // TODO: handle errors with custom description
                    return
                }
                guard let data = data else {
                    seal.reject(RemoteAPIError.unknown)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(TransformersData.self, from: data)
                    seal.fulfill(response.transformers)
                } catch let error as NSError {
                    seal.reject(error)
                }
            }.resume()
        }
    }
    
    public func change(_ request: TransformerRequest) -> Promise<TransformerData> {
        return Promise<TransformerData> { seal in
            
            guard let _ = authorizationToken else {
                seal.reject(RemoteAPIError.needAuthentication)
                return
            }
            
            guard let url = Services.transformers.getURL() else {
                seal.reject(RemoteAPIError.createURL)
                return
            }
            
            guard let body = try? JSONEncoder().encode(request) else {
                fatalError("Error trying to encode request object")
            }
            
            let request = getRequest(for: url, verb: .put, body: body)
            
            urlSession.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    seal.reject(error)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    seal.reject(RemoteAPIError.unknown)
                    return
                }
                guard 200..<300 ~= httpResponse.statusCode else {
                    guard let _ = data else {
                        seal.reject(RemoteAPIError.httpError)
                        return
                    }
                    // TODO: handle errors with custom description
                    return
                }
                guard let data = data else {
                    seal.reject(RemoteAPIError.unknown)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(TransformerData.self, from: data)
                    seal.fulfill(response)
                } catch let error as NSError {
                    seal.reject(error)
                }
            }.resume()
        }
    }
    
    public func delete(_ id: String) -> Promise<Void> {
        return Promise<Void> { seal in
            
            guard let _ = authorizationToken else {
                seal.reject(RemoteAPIError.needAuthentication)
                return
            }
            
            guard let url = Services.transformers.getURL(id) else {
                seal.reject(RemoteAPIError.createURL)
                return
            }
            
            let request = getRequest(for: url, verb: .delete)
            
            urlSession.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    seal.reject(error)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    seal.reject(RemoteAPIError.unknown)
                    return
                }
                guard 200..<300 ~= httpResponse.statusCode else {
                    guard let _ = data else {
                        seal.reject(RemoteAPIError.httpError)
                        return
                    }
                    // TODO: handle errors with custom description
                    return
                }
                
                seal.fulfill_()
            }.resume()
        }
    }
}

private extension TransformersDataRemoteAPI {
    
    enum Services: String {
        case allspark
        case transformers
        
        func getURL(_ id: String? = nil) -> URL? {
            var urlString = "\(domainURL)/\(self.rawValue)"
            
            if let id = id {
                urlString.append("/\(id)")
            }
            
            return URL(string: urlString)
        }
    }
    
    enum HTTPVerb: String {
        case get
        case post
        case put
        case delete
    }
    
    func getRequest(for url: URL, verb: HTTPVerb, body: Data? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = verb.rawValue.uppercased()
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let authorizationToken = authorizationToken {
            let bearerToken = "Bearer \(authorizationToken)"
            request.addValue(bearerToken, forHTTPHeaderField: "Authorization")
        }
        
        request.httpBody = body
        
        return request
    }
}
