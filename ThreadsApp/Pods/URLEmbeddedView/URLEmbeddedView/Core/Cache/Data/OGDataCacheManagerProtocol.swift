//
//  OGDataCacheManagerProtocol.swift
//  URLEmbeddedView
//
//  Created by marty-suzuki on 2018/07/15.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import Foundation

/// Protocol of OGP cache manager
///
/// If define OGP Cahce manage class with this protocol, be able to set OGDataProvider.cacheManager.
@objc public protocol OGDataCacheManagerProtocol: NSObjectProtocol {
    var updateInterval: TimeInterval { get set }
    func fetchOrInsertOGCacheData(url: String, completion: @escaping (OGCacheData) -> ())
    func fetchOGCacheData(url: String, completion: @escaping (OGCacheData?) -> ())
    func updateIfNeeded(cache: OGCacheData)
    func deleteOGCacheDate(cache: OGCacheData, completion: ((Error?) -> Void)?)
}
