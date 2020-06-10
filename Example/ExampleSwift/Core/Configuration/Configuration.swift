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
    case MFMSPush
    case ThreadsGate
}



@objc
class Configuration: NSObject {
    
    
    class func string(forKey key: String) -> String {
        return Bundle.main.object(forInfoDictionaryKey: key) as? String ?? ""
    }
    
    class func bool(forKey key: String) -> Bool {
        return self.string(forKey: key) == "YES"
    }
    
    @objc
    public class func summary() -> String {
        
        
        let array = [NSLocalizedString("Configuration:", comment: ""),
                     "",
                     String.localizedStringWithFormat("Bundle Identifier: %@", self.string(forKey:"CFBundleIdentifier")),
                     String.localizedStringWithFormat("App Name: %@", self.string(forKey:"CFBundleName")),
                     String.localizedStringWithFormat("App Version: %@", self.string(forKey:"CFBundleShortVersionString")),
                     String.localizedStringWithFormat("Lib Version: %@", Threads.threads().version()),
                     "",
                     String.init(format: "debugLoggingEnabled: %@", Threads.threads().isDebugLoggingEnabled ? "YES" : "NO"),
                     String.init(format: "productionMSMFServerEnabled: %@", Threads.threads().isProductionMFMSServer ? "YES" : "NO"),
                     String.init(format: "clientIdEncrypted: %@", Threads.threads().isClientIdEncrypted ? "YES" : "NO"),
                     "",
                     String.init(format: "historyURL: %@", Threads.threads().historyURL?.absoluteString ?? ""),
                     String.init(format: "fileUploadingURL: %@", Threads.threads().fileUploadingURL?.absoluteString ?? ""),
                     String.init(format: "signatureServerURL: %@", SignatureService.instance.serverURL?.absoluteString ?? "")
        ]
        
        return array.joined(separator: "\n")
    }
}
