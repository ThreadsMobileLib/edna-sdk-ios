//
//  OGCacheData.swift
//  URLEmbeddedView
//
//  Created by marty-suzuki on 2018/07/15.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import Foundation

/// OGP cache object
@objc public final class OGCacheData: NSObject {
    @objc var openGraphData: OpenGraphData {
        return ogData as OpenGraphData
    }
    @nonobjc public let ogData: OpenGraph.Data
    @objc public let createDate: Date
    @objc public let updateDate: Date?

    @objc
    init(ogData: OpenGraphData, createDate: Date, updateDate: Date?) {
        self.ogData = ogData as OpenGraph.Data
        self.createDate = createDate
        self.updateDate = updateDate
    }

    @nonobjc
    init(ogData: OpenGraph.Data, createDate: Date, updateDate: Date?) {
        self.ogData = ogData
        self.createDate = createDate
        self.updateDate = updateDate
    }
}
