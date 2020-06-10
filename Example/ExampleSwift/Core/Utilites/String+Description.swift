//
//  String+Description.swift
//  ExampleSwift
//
//  Created by Brooma Service on 29.04.2020.
//  Copyright © 2020 Threads. All rights reserved.
//

import Foundation

extension String {
    
    init(describingOpt: Any?) {

        if (describingOpt == nil) {
            self = String(describing: describingOpt)
        } else {
            self = String(describing: describingOpt!)
        }
    }
}
