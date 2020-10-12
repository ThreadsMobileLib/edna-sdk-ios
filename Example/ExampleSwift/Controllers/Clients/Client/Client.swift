//
//  Client.swift
//  ExampleSwift
//
//  Created by Brooma Service on 29.04.2020.
//  Copyright © 2020 Threads. All rights reserved.
//

import UIKit

@objc
class Client: NSObject, NSCoding, Codable {
    //TODO after few releases:
    //remove @objc, NSObject, NSCoding
    //add Equatable, CustomStringConvertible
    
    static let kIdKey = "client_id"
    static let kClientNameKey = "client_name"
    static let kClientAppMarkerKey = "app_marker"
    static let kSignatureKey = "client_id_signature"
    static let kDataKey = "data"
    
    let id: String
    let name: String?
    let appMarker: String?
    var signature: String?
    let data: String?
    
    init(id: String, name: String?, appMarker: String?, signature: String?, data: String?) {
        self.id = id
        self.name = name
        self.appMarker = appMarker
        self.signature = signature
        self.data = data
    }
    
    static func == (lhs: Client, rhs: Client) -> Bool {
        
        return lhs.id == rhs.id
            && lhs.name == rhs.name
            && lhs.appMarker == rhs.appMarker
            && lhs.signature == rhs.signature
            && lhs.data == rhs.data
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.id, forKey: Client.kIdKey)
        coder.encode(self.name, forKey: Client.kClientNameKey)
        coder.encode(self.appMarker, forKey: Client.kClientAppMarkerKey)
        coder.encode(self.signature, forKey: Client.kSignatureKey)
        coder.encode(self.data, forKey: Client.kDataKey)
    }
    
    required init?(coder: NSCoder) {
        self.id = coder.decodeObject(forKey: Client.kIdKey) as! String
        self.name = coder.decodeObject(forKey: Client.kClientNameKey) as? String
        self.appMarker = coder.decodeObject(forKey: Client.kClientAppMarkerKey) as? String
        self.signature = coder.decodeObject(forKey: Client.kSignatureKey) as? String
        self.data = coder.decodeObject(forKey: Client.kDataKey) as? String
    }
}
