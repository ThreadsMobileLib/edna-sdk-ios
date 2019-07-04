//
//  PlistUtils.swift
//  THRAppSwift-Polarbear
//
//  Created by Brooma Service on 14/05/2019.
//  Copyright © 2019 Brooma Service. All rights reserved.
//

import Foundation

@objc class PlistUtils : NSObject {
    
    @objc
    class func getStringFrom(dictName: String, byKey key: String) -> String? {
        
        let dict = Bundle.main.infoDictionary?[dictName] as? Dictionary<String, Any>
        return dict?[key] as? String
    }
    
    @objc
    class func getStringFromPlist(byKey key: String) -> String? {
        return Bundle.main.infoDictionary?[key] as? String
    }
    
    @objc
    class func getAppVersion() -> String {
        return getStringFromPlist(byKey: "CFBundleShortVersionString")! // CFBundleShortVersionString must always exist
    }
}
