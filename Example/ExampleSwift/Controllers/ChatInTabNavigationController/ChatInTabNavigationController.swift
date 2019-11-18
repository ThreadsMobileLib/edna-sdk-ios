//
//  ChatInTabNavigationController.swift
//  ExampleSwift
//
//  Created by Vitaliy Kuzmenko on 07/08/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

import UIKit
import Threads

class ChatInTabNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewControllers = [self.getChatViewController()]
    }
    
    func getAttributes() -> THRAttributes {
        let attributes = THRAttributes()
        return attributes
    }
    
    func getChatViewController() -> UIViewController {
        let attributes = getAttributes()
        let chatViewController = Threads.threads().chatViewController(with: attributes)
        return chatViewController
    }

}
