//
//  OGRequest.swift
//  URLEmbeddedView
//
//  Created by marty-suzuki on 2017/10/08.
//  Copyright © 2017年 marty-suzuki. All rights reserved.
//

import Foundation

private let userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Safari/601.1.42"

protocol OGRequest {
    associatedtype Response
    var url: URL { get }
    var urlRequest: URLRequest { get }
    static func response(data: Data) throws -> Response
}

extension OGRequest {
    var urlRequest: URLRequest {
        var request = URLRequest(url: url)
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        return request
    }
}
