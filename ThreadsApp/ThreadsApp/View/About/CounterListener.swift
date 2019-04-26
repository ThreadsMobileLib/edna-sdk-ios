//
//  CounterListener.swift
//  ThreadsApp
//
//  Created by Brooma Service on 03/10/2018.
//  Copyright © 2018 Brooma Service. All rights reserved.
//

import Foundation
import Threads

// Test class for accessing unreadedMessagesCountChanged from Swift
@objc class CounterListener : NSObject {
    
    override init() {
        Threads.threads().unreadedMessagesCountChanged = { (messagesCount) in
            print("SWIFT COUNTER LISTENER, count = ", messagesCount);
        }
        
        //Check Swift version
        #if swift(>=5.0)
            print("Hello, Swift 5.0")
        #elseif swift(>=4.2)
            print("Hello, Swift 4.2")
        #elseif swift(>=4.1)
            print("Hello, Swift 4.1")
        #elseif swift(>=4.0)
            print("Hello, Swift 4.0")
        #elseif swift(>=3.2)
            print("Hello, Swift 3.2")
        #elseif swift(>=3.0)
            print("Hello, Swift 3.0")
        #elseif swift(>=2.2)
            print("Hello, Swift 2.2")
        #elseif swift(>=2.1)
            print("Hello, Swift 2.1")
        #elseif swift(>=2.0)
            print("Hello, Swift 2.0")
        #elseif swift(>=1.2)
            print("Hello, Swift 1.2")
        #elseif swift(>=1.1)
            print("Hello, Swift 1.1")
        #elseif swift(>=1.0)
            print("Hello, Swift 1.0")
        #endif
    }
}
