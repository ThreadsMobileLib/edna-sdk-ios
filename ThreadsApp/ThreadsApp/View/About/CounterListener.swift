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
    }
}
