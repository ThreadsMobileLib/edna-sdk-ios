//
//  ConfigHelper.swift
//  THRAppSwift-Polarbear
//
//  Created by Brooma Service on 14/05/2019.
//  Copyright © 2019 Brooma Service. All rights reserved.
//

import Foundation

@objc class ConfigHelper : NSObject {
    
    static let kTHRConfigDictKey = "THR_APP_CONFIG";
    static let kTHRServerUrlKey = "THR_SERVER_URL";
    
    @objc 
    class func getServerUrl() -> String? {
        return PlistUtils.getStringFrom(dictName: kTHRConfigDictKey, byKey: kTHRServerUrlKey)
    }
}
