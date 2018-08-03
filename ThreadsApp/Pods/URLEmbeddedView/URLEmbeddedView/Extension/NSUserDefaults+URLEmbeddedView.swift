//
//  NSUserDefaults+URLEmbeddedView.swift
//  Pods
//
//  Created by 鈴木大貴 on 2016/04/05.
//
//

import Foundation

extension UserDefaults {
    private struct CacheKey {
        static let updateIntervalForOGData = "UpdateIntervalForOGDataCache"
    }
    
    var updateIntervalForOGData: TimeInterval? {
        get {
            let ud = UserDefaults.standard
            guard let interval = (ud.object(forKey: CacheKey.updateIntervalForOGData) as? NSNumber)?.doubleValue else {
                return nil
            }
            return interval
        }
        set {
            guard let interval = newValue else { return }
            let ud = UserDefaults.standard
            ud.set(NSNumber(value: interval), forKey: CacheKey.updateIntervalForOGData)
            ud.synchronize()
        }
    }
}
