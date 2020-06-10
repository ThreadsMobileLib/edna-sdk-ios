//
//  SignatureService.swift
//  ExampleSwift
//
//  Created by Brooma Service on 29.04.2020.
//  Copyright © 2020 Threads. All rights reserved.
//

import UIKit

class SignatureService: NSObject {

    static let instance = SignatureService()
    
    static let kAPI = "api"
    static let kSignaturePath = "auth/getSignature"
    static let kSignatureResponseKey = "encodedSignature"
    static let kIsDebugLoggingEnabled = true
    static let kTHRSignatureRequestTimeOut: TimeInterval = 2
    
    typealias THRClientIdSignatureCompletion = (String?, Error?) -> Void
    
    var serverURL: URL?
    
    private override init() {
        
    }

    public func getSignature(for clientId: String, completion: @escaping THRClientIdSignatureCompletion) {
        
        guard let url = URL(string: SignatureService.kAPI + "/" + SignatureService.kSignaturePath + "?clientId=" + clientId,
                            relativeTo: serverURL)
            else {
                let error = self.error(localizedDescription: NSLocalizedString("Signature URL is invalid", comment: ""))
                completion(nil, error)
                return
                
        }
        
        let request = URLRequest(url: url,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: SignatureService.kTHRSignatureRequestTimeOut)
        log(request: request)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
         
            self.log(response: response, data: data)
            
            if let error = error {
                self.log(error: error, category: "CONNECTION")
                completion(nil, error)
            } else {
                
                if let signature = self.parseSignature(from: data) {
                    completion(signature, nil)
                
                } else {
                    let error = self.error(localizedDescription: NSLocalizedString("clientSignature is absent or empty", comment: ""))
                    self.log(error: error, category: "SERIALIZATION")
                    
                    completion(nil, error);
                }
            }
        }.resume()
    }
    
    func parseSignature(from data: Data?) -> String? {
        
        if let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            let signature = json[SignatureService.kSignatureResponseKey] as? String {
        
            return signature
        
        } else {
            return nil
        }
    }

    func serializeResponse(withData data: Data?, completion: THRClientIdSignatureCompletion) {
        
        if let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            let signature = json[SignatureService.kSignatureResponseKey] as? String {
            
            completion(signature, nil)
            
        } else {
            let error = self.error(localizedDescription: NSLocalizedString("clientSignature is absent or empty", comment: ""))
            log(error: error, category: "SERIALIZATION")
            completion(nil, error);
        }
        
        
        
        
        
//        guard let data = data else {
//
//            let error = self.error(localizedDescription: NSLocalizedString("clientSignature is absent or empty", comment: ""))
//            log(error: error, category: "SERIALIZATION")
//            completion(nil, error);
//        }
//
//        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//        let signature = json?[SignatureService.kSignatureResponseKey] as? String
//
//        if let signature = signature {
//
//            if (!signature.isEmpty) {
//                completion(signature, nil)
//
//            } else {
//                let error = self.error(localizedDescription: NSLocalizedString("clientSignature is absent or empty", comment: ""))
//                log(error: error, category: "SERIALIZATION")
//                completion(nil, error);
//            }
//
//
//        } else {
//            let error = self.error(localizedDescription: NSLocalizedString("clientSignature is absent or empty", comment: ""))
//            log(error: error, category: "SERIALIZATION")
//            completion(nil, error);
//        }
        
    }

    func log(request: URLRequest) {
        if (SignatureService.kIsDebugLoggingEnabled) {
            print("SignatureService: REQUEST = \(request)")
            print("SignatureService: REQUEST HTTP HEADER FIELDS = \(String(describing: request.allHTTPHeaderFields))")
        }
    }

    func log(response: URLResponse?, data: Data?) {
        if (SignatureService.kIsDebugLoggingEnabled) {
            
            var dataString: String
            if let data = data, let parsedString = String(data: data, encoding: .utf8) {
                dataString = parsedString
            } else {
                dataString = NSLocalizedString("Empty", comment: "")
            }
            
            print("SignatureService: RESPONSE = \(String(describing: response))")
            print("SignatureService: RESPONSE DATA = \(dataString))")
        }
    }

    func log(error: Error, category: String) {
        print("SignatureService: %@ ERROR = \(category), \(error.localizedDescription)")
    }

    func error(localizedDescription: String) -> Error {
        
        return NSError(domain: Bundle(for: SignatureService.self).bundleIdentifier ?? "unkown bundle",
                       code: 0,
                       userInfo: [NSLocalizedDescriptionKey: localizedDescription])
    }
}
