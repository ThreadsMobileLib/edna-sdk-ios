//
//  IntegrationsViewController+UITableViewDelegate.swift
//  ExampleSwift
//
//  Created by Vitaliy Kuzmenko on 07/08/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

import Foundation

enum IntegrationSection: Int {
    case design, push, present
}

enum IntegrationPushSection: Int {
    case pushWithTabBar, pushWithoutTabBar
}

enum IntegrationPresentSection: Int {
    case present, presentInTabBar, presentInTabBarStoryboard
}

extension IntegrationsViewController {
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch IntegrationSection(rawValue: indexPath.section)! {
        case .design:
            break
        case .push:
            tableViewDidSelectPushSection(with: IntegrationPushSection(rawValue: indexPath.row)!)
        case .present:
            tableViewDidSelectPresentSection(with: IntegrationPresentSection(rawValue: indexPath.row)!)
        }
    }
    
    func tableViewDidSelectPushSection(with method: IntegrationPushSection) {
        switch method {
        case .pushWithTabBar:
            pushChatInCurrentNavigationController()
        case .pushWithoutTabBar:
            pushChatInCurrentNavigationControllerWithHidingTabBar()
        }
    }
    
    func tableViewDidSelectPresentSection(with method: IntegrationPresentSection) {
        switch method {
        case .present:
            presentChatInUINavigationController()
        case .presentInTabBar:
            presentChatUINavigationControllerAsTabInTabBarControllerInitializatedFromCode()
        case .presentInTabBarStoryboard:
            presentChatUINavigationControllerAsTabInTabBarControllerInitializatedFromStoryboard()
        }
    }
    
}
