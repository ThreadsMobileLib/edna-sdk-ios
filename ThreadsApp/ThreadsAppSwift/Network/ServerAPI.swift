//
//  ServerAPI.swift
//  THRAppSwift-Polarbear
//
//  Created by Brooma Service on 15/05/2019.
//  Copyright © 2019 Brooma Service. All rights reserved.
//

import Foundation

typealias THRClientIdSignatureCompletion = (String?, Error?) -> Void

class ServerAPI {
    
    static let kAPI = "api/"
    static let kSignatureEndpoint = "auth/getSignature/"
    static let kSignatureResponseKey = "encodedSignature"
    static let kIsDebugLoggingEnabled = true
    
    
    class func getSignature(forClientId clientId: String, withCompletion completion: @escaping THRClientIdSignatureCompletion) {
        
        let baseUrl = ConfigHelper.getServerUrl()
        
        if (!(baseUrl ?? "").isEmpty) {
            
            let urlString = String.init(format: "%@%@%@?clientId=%@", baseUrl!, ServerAPI.kAPI, ServerAPI.kSignatureEndpoint, clientId)
            
            if let url = URL(string: urlString) {
                loadSignature(withUrl: url, completion: completion)
            } else {
                print("Signature loading failed: Server url invalid: ", urlString)
            }
            
        } else {
            let signatureLoadError = NSError(domain: Bundle(for: self).bundleIdentifier ?? "",
                                             code: 0,
                                             userInfo: ["error_description": "Signature loading failed: Server url empty"])
            
            print("Load signature: ERROR    = ", signatureLoadError);
            completion(nil, signatureLoadError);
        }
    }
    
    class func loadSignature(withUrl url: URL, completion: @escaping THRClientIdSignatureCompletion) {
        
        var signatureRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 2.0)
        signatureRequest.httpMethod = "GET"
        
        
        if (ServerAPI.kIsDebugLoggingEnabled) {
            print("Load signature: REQUEST =", signatureRequest)
            print("Load signature: HEADERS =", signatureRequest.allHTTPHeaderFields ?? "nil")
        }
        
        URLSession.shared.dataTask(with: signatureRequest) { (data, response, error) in
            
            if (ServerAPI.kIsDebugLoggingEnabled) {
                print("Load signature: RESPONSE = ", response ?? "nil");
                print("Load signature: DATA     = ", (data == nil) ? "nil" : String(data: data!, encoding: .utf8) ?? "nil");
            }
            
            if (error != nil) {
                print("Load signature: ERROR    = ", error!)
                completion(nil, error)
            } else {
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, Any>
                    
                    let signature = json?[ServerAPI.kSignatureResponseKey] as? String
                    
                    if (!(signature ?? "").isEmpty) {
                        completion(signature, nil);
                    } else {

                        let signatureDataError = NSError(domain: Bundle(for: self).bundleIdentifier ?? "",
                                                         code: 0,
                                                         userInfo: ["error_description": "clientSignature is absent or empty"])
                        
                        print("Load signature: ERROR    = ", signatureDataError);
                        completion(nil, signatureDataError);
                    }
                    
                } catch let jsonError {
                    print("Load signature: ERROR    = ", jsonError);
                    completion(nil, jsonError);
                }
            }
        }.resume()
        
    }
    
}
