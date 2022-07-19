//
//  Configuration.swift
//  ExampleSwift
//
//  Created by Brooma Service on 27.04.2020.
//  Copyright © 2020 Threads. All rights reserved.
//

import UIKit
import Threads

enum TransportProtocol: String {
    case EDNAPush
    case ThreadsGate
}

@objc
class Configuration: NSObject {
    
    public class func debugLoggingEnabled() -> Bool {
        return self.bool(forKey: "THR_DEBUG_LOGGING_ENABLED")
    }
        
    public class func productionMSMFServerEnabled() -> Bool {
        return self.bool(forKey: "THR_IS_PRODUCTION_EDNA_SERVER_ENABLED")
    }
        
    public class func clientIdEncrypted() -> Bool {
        return self.bool(forKey: "THR_CLIENTID_IS_ENCRYPTED")
    }

    public class func transportProtocol() -> TransportProtocol {
        
        return TransportProtocol.init(rawValue: self.string(forKey: "THR_TRANSPORT_PROTOCOL"))
            ?? TransportProtocol.ThreadsGate
    }

    public class func webSocketURL() -> String? {
        return self.string(forKey: "THR_WEBSOCKET_URL")
    }

    public class func providerUid() -> String? {
        return self.string(forKey: "THR_PROVIDER_UID")
    }

    public class func historyURL() -> String {
        return self.string(forKey: "THR_HISTORY_URL")
    }

    public class func dataStoreURL() -> String {
        return self.string(forKey: "THR_DATASTOR_URL")
    }
        
    public class func restServerURL() -> String {
        return self.string(forKey: "THR_REST_URL")
    }
        
    class func string(forKey key: String) -> String {
        return Bundle.main.object(forInfoDictionaryKey: key) as? String ?? ""
    }
        
    class func bool(forKey key: String) -> Bool {
        return self.string(forKey: key) == "YES"
    }
    
    class func int(forKey key: String) -> Int {
        return Int(self.string(forKey: key)) ?? 0
    }

    class func `protocol`() -> String {
        return self.transportProtocol().rawValue
    }
        
    @objc
    public class func summary() -> String {
        
        let array = [NSLocalizedString("Configuration:", comment: ""),
                     "",
                     String.localizedStringWithFormat("Protocol: %@", self.transportProtocol().rawValue),
                     String.localizedStringWithFormat("Language: %@", self.string(forKey:"THR_LANGUAGE")),
                     String.localizedStringWithFormat("Bundle Identifier: %@", self.string(forKey:"CFBundleIdentifier")),
                     String.localizedStringWithFormat("App Name: %@", self.string(forKey:"CFBundleName")),
                     String.localizedStringWithFormat("App Version: %@", self.string(forKey:"CFBundleShortVersionString")),
                     String.localizedStringWithFormat("Lib Version: %@", Threads.threads().version()),
                     "",
                     String.init(format: "debugLoggingEnabled: %@", self.debugLoggingEnabled() ? "YES" : "NO"),
                     String.init(format: "productionMSMFServerEnabled: %@", self.productionMSMFServerEnabled() ? "YES" : "NO"),
                     String.init(format: "clientIdEncrypted: %@", self.clientIdEncrypted() ? "YES" : "NO"),
                     "",
                     String.init(format: "historyURL: %@", self.historyURL()),
                     String.init(format: "dataStoreURL: %@", self.dataStoreURL()),
                     String.init(format: "restServerURL: %@", self.restServerURL())
        ];
        
        return array.joined(separator: "\n")
    }

}
