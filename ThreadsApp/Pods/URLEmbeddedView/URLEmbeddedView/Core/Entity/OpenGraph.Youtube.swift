//
//  OpenGraph.Youtube.swift
//  URLEmbeddedView
//
//  Created by marty-suzuki on 2018/07/14.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import Foundation

extension OpenGraph {
    struct Youtube: Codable {
        let title: String
        let type: String
        let providerName: String
        let thumbnailUrl: String
        let authorName: String

        enum CodingKeys: String, CodingKey {
            case title
            case type
            case providerName = "provider_name"
            case thumbnailUrl = "thumbnail_url"
            case authorName = "author_name"
        }
    }
}
