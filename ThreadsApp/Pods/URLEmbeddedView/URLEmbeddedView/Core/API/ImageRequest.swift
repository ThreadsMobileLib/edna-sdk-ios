//
//  ImageRequest.swift
//  URLEmbeddedView
//
//  Created by marty-suzuki on 2017/10/08.
//  Copyright © 2017年 marty-suzuki. All rights reserved.
//

import Foundation
import UIKit

struct ImageRequest: OGRequest {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    static func response(data: Data) throws -> (DataProtocol, UIImage) {
        return try (data, UIImage(data: data) ?? { throw OGSession.Error.imageGenerateFaild }())
    }
}
