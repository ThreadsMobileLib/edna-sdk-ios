//
//  MainViewController.swift
//  ExampleSwift
//
//  Created by Brooma Service on 24.04.2020.
//  Copyright © 2020 Threads. All rights reserved.
//

import UIKit

protocol IntegrationsProtocol {
    func presentFromPush(withDesign design: Int)
}

enum MainViewControllerTab: Int {
    case MainViewControllerTabClients = 0
    case MainViewControllerTabIntegrations = 1
    case MainViewControllerTabUtilites = 2
}

class MainViewController: UITabBarController, UITabBarControllerDelegate {
    
    var unreadMessagesBadgeValue: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    func setUnreadMessagesCount(_ unreadMessagesCount: UInt) {
        
        self.unreadMessagesBadgeValue = unreadMessagesCount > 0 ? "\(unreadMessagesCount)" : nil
        self.updateUnreadMessagesCountBadgeValue()
    }

    func updateUnreadMessagesCountBadgeValue() {
        
        let tabBarItem = self.viewControllers?[MainViewControllerTab.MainViewControllerTabIntegrations.rawValue].tabBarItem
        let nc = self.selectedViewController as? UINavigationController
        
        if (self.selectedIndex != MainViewControllerTab.MainViewControllerTabIntegrations.rawValue
            || ( nc?.visibleViewController is IntegrationsProtocol)) {
            tabBarItem?.badgeValue = self.unreadMessagesBadgeValue
        } else {
            tabBarItem?.badgeValue = nil
        }
    }

    func showChat(forAppMarker appMarker: String) {
        self.selectedIndex = 1;
        let nvc = self.viewControllers?[1] as? UINavigationController
        let vc = nvc?.viewControllers[0] as? IntegrationsProtocol
        let design = appMarker.hasSuffix("CRG") ? 1 : 0;
        vc?.presentFromPush(withDesign: design)
    }

    func tabBarController(_ tabBarController : UITabBarController, didSelect didSelectViewController: UIViewController) {
        self.updateUnreadMessagesCountBadgeValue()
    }

}
