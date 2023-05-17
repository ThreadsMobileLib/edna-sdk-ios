//
//  AppDelegate.swift
//  ExampleSwift
//
//  Created by Vitaliy Kuzmenko on 07/08/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

import UIKit
import Threads
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Step 1: Configure Threads Framework
        configureThreads()
        
        // Step 2: Register device for remote notifications
        registerForRemoteNotifications()
        
        return true
    }
    
    // MARK: - Application Setup Configuration
    
    func configureThreads() {
        let threads = Threads.threads()
        threads.isClientIdEncrypted = false
        threads.isShowsNetworkActivity = true
        threads.attributes.logLevels = .all

        threads.configureTransportProtocol(
            with: self,
            webSocketURL: URL(string: "WEBSOCKET_URL")!,
            providerUid: "PROVIDER_UID",
            restURL: URL(string: "REST_URL")!,
            dataStoreURL: URL(string: "DATASTORE_URL")!)
    }
    
    func registerForRemoteNotifications() {
        UNUserNotificationCenter.current().delegate = self

        Threads.threads().registerApplicationForRemoteNotificationsStandartOptions(authorizationStatusDenied: {
            print("Remote notifications denied")
        }) { deviceToken in
            print("Application registered for remote notifications \(deviceToken?.description ?? "nil")")
        }
    }

    func application(_: UIApplication, open url: URL, options _: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        print(url.absoluteString)
        return true
    }
    
    // MARK: - Remote Notifications

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Threads.threads().applicationDidRegisterForRemoteNotifications(withDeviceToken: deviceToken)
    }
    
    func handleOpeningFromPush(with userInfo: [AnyHashable: Any]) {
        if Threads.threads().isThreadsOriginPushUserInfo(userInfo) {
            // Application launched from Threads notification
            if let appMarker = Threads.threads().getAppMarker(fromPushUserInfo: userInfo) {
                let vc = self.window?.rootViewController as? MainViewController
                vc?.showChat(forAppMarker: appMarker, pushUserInfo: [:])
            }
        } else {
            // Application launched from other notifications
        }
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Check for application launched from notification
        if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
            let userInfo = response.notification.request.content.userInfo
            handleOpeningFromPush(with: userInfo)
        }
        completionHandler()
    }
}

extension AppDelegate: ThreadsDelegate {
    func threads(_ threads: Threads, unreadMessagesCount: UInt) {
        let vc = self.window?.rootViewController as? MainViewController
        vc?.setUnreadMessagesCount(unreadMessagesCount)
    }
    
    func threads(_ threads: Threads, didReceiveError error: Error) {
        print("Threads received error = \(error.localizedDescription)")
    }
    
    func threads(_ threads: Threads, didChangeDeviceAddress deviceAddress: String) {
        print("Threads did change deviceAddress = \(deviceAddress)")
    }
}
