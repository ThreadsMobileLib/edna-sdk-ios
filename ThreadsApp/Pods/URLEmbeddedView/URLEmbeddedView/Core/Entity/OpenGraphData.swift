//
//  OpenGraphData.swift
//  URLEmbeddedView
//
//  Created by marty-suzuki on 2018/07/14.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import Foundation

/// OGP object for Objective-C
@objc public class OpenGraphData: NSObject {
    @objc public let imageUrl: URL?
    @objc public let pageDescription: String?
    @objc public let pageTitle: String?
    @objc public let pageType: String?
    @objc public let siteName: String?
    @objc public let sourceUrl: URL?
    @objc public let url: URL?

    init(source: OpenGraph.Data) {
        self.imageUrl = source.imageUrl
        self.pageDescription = source.pageDescription
        self.pageTitle = source.pageTitle
        self.pageType = source.pageType
        self.siteName = source.siteName
        self.sourceUrl = source.sourceUrl
        self.url = source.url
    }
}
