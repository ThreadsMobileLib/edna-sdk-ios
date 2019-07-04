//
//  Client.swift
//  THRAppSwift-Polarbear
//
//  Created by Brooma Service on 17/05/2019.
//  Copyright © 2019 Brooma Service. All rights reserved.
//

import Foundation
@objc(Client)
class Client : NSObject, NSCoding {
    
    static let kClientIdKey = "client_id"
    static let kClientNameKey = "client_name"
    static let kClientAppMarkerKey = "app_marker"
    static let kClientIdSignatureKey = "client_id_signature"
    
    var clientId : String!
    var name : String?
    var appMarker : String?
    var clientIdSignature : String?
    
    init(withId id: String, name: String?, appMarker: String?, clientIdSignature: String?) {
        self.clientId = id;
        self.name = name;
        self.appMarker = appMarker;
        self.clientIdSignature = clientIdSignature;
    }
    
    init(withDict dict: Dictionary<String, String>) {
        self.clientId = dict[Client.kClientIdKey];
        self.name = dict[Client.kClientNameKey];
        self.appMarker = dict[Client.kClientAppMarkerKey];
        self.clientIdSignature = dict[Client.kClientIdSignatureKey];
    }
    
    static func ==(first: Client, second: Client) -> Bool {
        return first.clientId == second.clientId
            && first.clientIdSignature == second.clientIdSignature
            && first.name == second.name
            && first.appMarker == second.appMarker
    }
    
    //MARK: - NSCoding
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(self.clientId, forKey: Client.kClientIdKey)
        aCoder.encode(self.name, forKey: Client.kClientNameKey)
        aCoder.encode(self.appMarker, forKey: Client.kClientAppMarkerKey)
        aCoder.encode(self.clientIdSignature, forKey: Client.kClientIdSignatureKey)
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        
        if let clientId = aDecoder.decodeObject(forKey: Client.kClientIdKey) as? String
            , let name = aDecoder.decodeObject(forKey: Client.kClientNameKey) as? String
            , let appMarker = aDecoder.decodeObject(forKey: Client.kClientAppMarkerKey) as? String
            , let clientIdSignature = aDecoder.decodeObject(forKey: Client.kClientIdSignatureKey) as? String {
            self.init(withId: clientId, name: name, appMarker: appMarker, clientIdSignature: clientIdSignature)
            
        } else {
            return nil
        }
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        
        if super.isEqual(object) {
            return true
            
        } else if let otherClient = object as? Client {
            return self.clientId == otherClient.clientId
                && self.clientIdSignature == otherClient.clientIdSignature
                && self.appMarker == otherClient.appMarker
                && self.name == otherClient.name
            
        } else {
            return false
        }
    }
    
    override var hash: Int {
        return self.clientId.hashValue ^ self.appMarker.hashValue ^ self.clientIdSignature.hashValue ^ self.name.hashValue
    }
}
