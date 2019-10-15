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
        
        // Step 3: (Only for Demo App) Configure SignatureService for receiving client signature form server.
        configureSignatureService()
        
        return true
    }
    
    // MARK: - Application Setup Configuration
    
    func configureThreads() {
        let threads = Threads.threads()
        threads.isDebugLoggingEnabled = true
        threads.isClientIdEncrypted = false
        threads.isShowsNetworkActivity = true
        
        threads.configure(
            with: self,
            productionMFMSServer: true,
            historyURL: URL(string: "https://polarbearstore.threads.im/")!,
            fileUploadingURL: URL(string: "https://polarbearstore.threads.im/files")!
        )
    }
    
    func registerForRemoteNotifications() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        }
        Threads.threads().registerApplicationForRemoteNotificationsStandartOptions(authorizationStatusDenied: {
            print("Remote notifications denied")
        }) { deviceToken in
            print("Application registered for remote notifications \(deviceToken?.description ?? "nil")")
        }
    }
    
    func configureSignatureService() {
        SignatureService.sharedInstance().serverURL = URL(string: "https://polarbear.threads.im")!
    }
    
    // MARK: - Remote Notifications
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        Threads.threads().applicationDidRegister(notificationSettings)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Threads.threads().applicationDidRegisterForRemoteNotifications(withDeviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        Threads.threads().applicationDidFailToRegisterForRemoteNotificationsWithError(error)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        Threads.threads().applicationDidReceiveRemoteNotification(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Threads.threads().applicationDidReceiveRemoteNotification(userInfo) { state in
            completionHandler(.newData)
        }
    }
    
    func handleOpeningFromPush(with userInfo: [AnyHashable: Any]) {
        if Threads.threads().isThreadsOriginPushUserInfo(userInfo) {
            // Application launched from Threads notification
            let appMarker = Threads.threads().getAppMarker(fromPushUserInfo: userInfo)
            let vc = self.window?.rootViewController as? MainViewController
            vc?.showChat(forAppMarker: appMarker)
        } else {
            // Application launched from other notifications
        }
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        Threads.threads().applicationDidReceiveRemoteNotification(notification.request.content.userInfo) { state in
            completionHandler([])
        }
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Check for application launched from notification
        if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
            let userInfo = response.notification.request.content.userInfo
            handleOpeningFromPush(with: response.notification.request.content.userInfo)
        }
        completionHandler()
    }
    
}

extension AppDelegate: ThreadsDelegate {
    
    func threads(_ threads: Threads, didReceiveFullMessages messages: [PushNotificationMessage]) {
        // Use this delegate method for access to received full data messages
    }
    
    func threads(_ threads: Threads, unreadMessagesCount: UInt) {
        let vc = self.window?.rootViewController as? MainViewController
        vc?.setUnreadMessagesCount(unreadMessagesCount)
    }
    
    func threads(_ threads: Threads, didReceiveError error: Error) {
        print("Threads received error = \(error.localizedDescription)")
    }
    
}
