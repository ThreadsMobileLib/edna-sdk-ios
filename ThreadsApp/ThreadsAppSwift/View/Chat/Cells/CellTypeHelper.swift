//
//  CellTypeHelper.swift
//  THRAppSwift-Polarbear
//
//  Created by Brooma Service on 17/05/2019.
//  Copyright © 2019 Brooma Service. All rights reserved.
//

import Foundation
import Threads

enum CellType : String, CaseIterable {
    case Version
    case Design
    case DebugMode
    case FragmentChat
    case FullChat
    case OtherChats
    case OutsideText
    case OutsideImage
}

class CellTypeHelper {
    
    class func getCellText(forType type: CellType) -> String {
        
        switch type {
            
        case .Version:
            return String(format: "ThreadsLib - v%@\nThreadsApp - v%@", Threads.version(), PlistUtils.getAppVersion())
            
        case .Design:
            return "Design"
            
        case .DebugMode:
            return "Debug-mode"
            
        case .FragmentChat:
            return String(format: "%@ %@",
                          NSLocalizedString("show_chat_title", comment: ""),
                          NSLocalizedString("chat_fragment_title", comment: ""))
        case .FullChat:
            return String(format: "%@ %@",
                          NSLocalizedString("show_chat_title", comment: ""),
                          NSLocalizedString("chat_full_controller_title", comment: ""))
        case .OtherChats:
            return "Other Chat Integrations"
        case .OutsideText:
            return "Outside Text Message"
        case .OutsideImage:
            return "Outside Image Message"
        }
    }
    
}
