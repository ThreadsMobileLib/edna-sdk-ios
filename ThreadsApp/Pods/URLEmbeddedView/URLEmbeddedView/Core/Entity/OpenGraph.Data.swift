//
//  OpenGraph.Data.swift
//  URLEmbeddedView
//
//  Created by marty-suzuki on 2018/07/14.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import Foundation

extension OpenGraph {

    /// OGP object for Swift
    public struct Data {
        public let imageUrl: URL?
        public let pageDescription: String?
        public let pageTitle: String?
        public let pageType: String?
        public let siteName: String?
        public let sourceUrl: URL?
        public let url: URL?
    }
}

extension OpenGraph.Data {
    var isEmpty: Bool {
        if let value = imageUrl?.absoluteString, !value.isEmpty {
            return false
        }
        if let value = pageDescription, !value.isEmpty {
            return false
        }
        if let value = pageTitle, !value.isEmpty {
            return false
        }
        if let value = pageType, !value.isEmpty {
            return false
        }
        if let value = siteName, !value.isEmpty {
            return false
        }
        if let value = url?.absoluteString, !value.isEmpty {
            return false
        }
        return true
    }

    init(ogData: OGData) {
        imageUrl = URL(string: ogData.imageUrl)
        pageDescription = ogData.pageDescription.isEmpty ? nil : ogData.pageDescription
        pageTitle = ogData.pageTitle.isEmpty ? nil : ogData.pageTitle
        pageType = ogData.pageType.isEmpty ? nil : ogData.pageType
        siteName = ogData.siteName.isEmpty ? nil : ogData.siteName
        sourceUrl = URL(string: ogData.sourceUrl)
        url = URL(string: ogData.url)
    }

    init(youtube: OpenGraph.Youtube, sourceUrl: String) {
        self.pageTitle = youtube.title
        self.pageType = youtube.type
        self.siteName = youtube.providerName
        self.imageUrl = URL(string: youtube.thumbnailUrl)
        self.pageDescription = youtube.authorName
        let url = URL(string: sourceUrl)
        self.sourceUrl = url
        self.url = url
    }

    static func empty() -> OpenGraph.Data {
        return .init(imageUrl: nil,
                     pageDescription: nil,
                     pageTitle: nil,
                     pageType: nil,
                     siteName: nil,
                     sourceUrl: nil,
                     url: nil)
    }
}

extension OpenGraph.Data {
    private enum PropertyName {
        case description
        case image
        case siteName
        case title
        case type
        case url

        init?(_ meta: OpenGraph.HTML.Metadata) {
            let property = meta.property
            let content = meta.content
            if property.contains("og:description") {
                self = .description
            } else if property.contains("og:image") && content.contains("http") {
                self = .image
            } else if property.contains("og:site_name") {
                self = .siteName
            } else if property.contains("og:title") {
                self = .title
            } else if property.contains("og:type") {
                self = .type
            } else if property.contains("og:url") {
                self = .url
            } else {
                return nil
            }
        }
    }

    init(sourceUrl: String) {
        self.imageUrl = nil
        self.pageDescription = nil
        self.pageTitle = nil
        self.pageType = nil
        self.siteName = nil
        self.sourceUrl = URL(string: sourceUrl)
        self.url = nil
    }

    init(html: OpenGraph.HTML, sourceUrl: String) {
        let data = html.metaList.reduce(OpenGraph.Data(sourceUrl: sourceUrl)) { r, m in
            guard let propertyName = PropertyName(m) else {
                return r
            }
            switch propertyName  {
            case .siteName:
                return OpenGraph.Data(imageUrl: r.imageUrl,
                                      pageDescription: r.pageDescription,
                                      pageTitle: r.pageTitle,
                                      pageType: r.pageType,
                                      siteName: m.content,
                                      sourceUrl: r.sourceUrl,
                                      url: r.url)
            case .type:
                return OpenGraph.Data(imageUrl: r.imageUrl,
                                      pageDescription: r.pageDescription,
                                      pageTitle: r.pageTitle,
                                      pageType: m.content,
                                      siteName: r.siteName,
                                      sourceUrl: r.sourceUrl,
                                      url: r.url)
            case .title:
                return OpenGraph.Data(imageUrl: r.imageUrl,
                                      pageDescription: r.pageDescription,
                                      pageTitle: (try? m.unescapedContent()) ?? "",
                                      pageType: r.pageType,
                                      siteName: r.siteName,
                                      sourceUrl: r.sourceUrl,
                                      url: r.url)
            case .image:
                return OpenGraph.Data(imageUrl: URL(string: m.content),
                                      pageDescription: r.pageDescription,
                                      pageTitle: r.pageTitle,
                                      pageType: r.pageType,
                                      siteName: r.siteName,
                                      sourceUrl: r.sourceUrl,
                                      url: r.url)
            case .url         :
                return OpenGraph.Data(imageUrl: r.imageUrl,
                                      pageDescription: r.pageDescription,
                                      pageTitle: r.pageTitle,
                                      pageType: r.pageType,
                                      siteName: r.siteName,
                                      sourceUrl: r.sourceUrl,
                                      url: URL(string: m.content))
            case .description :
                return OpenGraph.Data(imageUrl: r.imageUrl,
                                      pageDescription: m.content.replacingOccurrences(of: "\n", with: " "),
                                      pageTitle: r.pageTitle,
                                      pageType: r.pageType,
                                      siteName: r.siteName,
                                      sourceUrl: r.sourceUrl,
                                      url: r.url)
            }
        }
        self.imageUrl = data.imageUrl
        self.pageDescription = data.pageDescription
        self.pageTitle = data.pageTitle
        self.pageType = data.pageType
        self.siteName = data.siteName
        self.sourceUrl = data.sourceUrl
        self.url = data.url
    }
}

extension OpenGraph.Data: _ObjectiveCBridgeable {
    public typealias _ObjectiveCType = OpenGraphData

    private init(source: OpenGraphData) {
        self.imageUrl = source.imageUrl
        self.pageDescription = source.pageDescription
        self.pageTitle = source.pageTitle
        self.pageType = source.pageType
        self.siteName = source.siteName
        self.sourceUrl = source.sourceUrl
        self.url = source.url
    }

    public func _bridgeToObjectiveC() -> OpenGraphData {
        return .init(source: self)
    }

    public static func _forceBridgeFromObjectiveC(_ source: OpenGraphData, result: inout OpenGraph.Data?) {
        result = .init(source: source)
    }

    public static func _conditionallyBridgeFromObjectiveC(_ source: OpenGraphData, result: inout OpenGraph.Data?) -> Bool {
        _forceBridgeFromObjectiveC(source, result: &result)
        return true
    }

    public static func _unconditionallyBridgeFromObjectiveC(_ source: OpenGraphData?) -> OpenGraph.Data {
        return .empty()
    }
}
