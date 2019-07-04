//
//  ChatInStackController.swift
//  THRAppSwift-Polarbear
//
//  Created by Brooma Service on 17/05/2019.
//  Copyright © 2019 Brooma Service. All rights reserved.
//

import Foundation
import Threads

class ChatInStackController : UIViewController {
    
    @IBOutlet weak var chatContainer : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Threads.show(in: self.chatContainer, parentController: self)
    }
    
}
