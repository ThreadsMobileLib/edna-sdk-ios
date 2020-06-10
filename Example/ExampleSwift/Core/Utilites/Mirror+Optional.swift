//
//  Mirror+Optional.swift
//  ExampleSwift
//
//  Created by Brooma Service on 29.04.2020.
//  Copyright © 2020 Threads. All rights reserved.
//

import Foundation

extension Mirror {
    
    static func unwrap<T>(_ any: T) -> Any {
        
        let mirror = Mirror(reflecting: any)
        
        if mirror.displayStyle == .optional, let first = mirror.children.first {
            return first.value
        } else {
            return any
        }
    }
    
    static func isOptional(_ any:Any) -> Bool {
        return Mirror(reflecting: any).displayStyle == .optional
    }
}
