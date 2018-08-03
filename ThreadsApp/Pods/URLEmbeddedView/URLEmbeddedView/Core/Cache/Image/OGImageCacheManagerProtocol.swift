//
//  OGImageCacheManagerProtocol.swift
//  URLEmbeddedView
//
//  Created by marty-suzuki on 2018/07/15.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import Foundation

protocol OGImageCacheManagerProtocol: class {
    func cachedImage(urlString: String) -> UIImage?
    func storeImage(_ image: UIImage, data: DataProtocol, urlString: String)
    func clearMemoryCache()
    func clearAllCache()
}
