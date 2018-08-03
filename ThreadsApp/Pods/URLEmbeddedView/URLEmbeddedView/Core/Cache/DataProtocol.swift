//
//  DataProtocol.swift
//  URLEmbeddedView
//
//  Created by marty-suzuki on 2018/07/15.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import Foundation

/// Use for Test
protocol DataProtocol {
    func write(to url: URL, options: Data.WritingOptions) throws
}

extension Data: DataProtocol {}
