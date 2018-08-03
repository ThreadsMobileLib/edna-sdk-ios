//
//  HtmlRequest.swift
//  URLEmbeddedView
//
//  Created by marty-suzuki on 2017/10/08.
//  Copyright © 2017年 marty-suzuki. All rights reserved.
//

import Foundation

struct HtmlRequest: OGRequest {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    static func response(data: Data) throws -> OpenGraph.HTML {
        guard let htmlString = String(data: data, encoding: .utf8) else {
            throw OGSession.Error.castFaild
        }
        return try OpenGraph.HTML(htmlString: htmlString) ?? { throw OGSession.Error.htmlDecodeFaild }()
    }
}
