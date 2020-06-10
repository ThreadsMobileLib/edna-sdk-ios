//
//  CustomStringConvertible+Mirror.swift
//  ExampleSwift
//
//  Created by Brooma Service on 29.04.2020.
//  Copyright © 2020 Threads. All rights reserved.
//

import Foundation

extension CustomStringConvertible {
    
    var description : String {
        
        var description: String = "\(type(of: self)): "
        
        let selfMirror = Mirror(reflecting: self)
        for child in selfMirror.children {
            
            if let propertyName = child.label {
                description += "\(propertyName): \(String(describingOpt:  Mirror.unwrap(child.value))), "
            }
        }
        
        if let superMirror = selfMirror.superclassMirror {
            for child in superMirror.children {
                if let propertyName = child.label {
                    description += "super.\(propertyName): \(String(describingOpt: Mirror.unwrap(child.value))), "
                }
            }
        }
        
        return description
    }
}
