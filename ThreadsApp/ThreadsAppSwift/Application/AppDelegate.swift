//
//  ThreadsApp
//
//  Copyright © 2019 Brooma Service. All rights reserved.
//
import UIKit
import UserNotifications

import MFMSPushLite
import MMDrawerController
import Threads

@UIApplicationMain
class AppDelegate: UIResponder, MFMSPushLiteDelegate, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    var window: UIWindow?
    
    private var drawerController: MMDrawerController?
    private var tabBarController: UITabBarController?
    private var pushAPI: MFMSPushLite?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        if #available(iOS 10, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.sound, .alert, .badge], completionHandler: { granted, error in
                if error == nil {
                    DispatchQueue.main.async(execute: {
                        UIApplication.shared.registerForRemoteNotifications()
                    })
                }
            })
        } else {
            UIApplication.shared.registerForRemoteNotifications()
        }
        
        
        Threads.setDebugLoggingEnabled(true)
        PushServerAPI.PUSH_API_LOG_ENABLE = false
        PushServerAPI.showNetworkActivity(true)
        
        pushAPI = MFMSPushLite(delegate: self)
        pushAPI?.autoRegisterForNotification = false
        pushAPI?.start()
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: type(of: self)))
        tabBarController = storyboard.instantiateViewController(withIdentifier: "CenterController") as? UITabBarController
        let rightDrawerController: UIViewController = storyboard.instantiateViewController(withIdentifier: "DrawerController")
        
        drawerController = MMDrawerController(center: tabBarController, rightDrawerViewController: rightDrawerController)
        drawerController?.showsShadow = false
        drawerController?.restorationIdentifier = "MMDrawer"
        drawerController?.maximumRightDrawerWidth = 200.0
        drawerController?.openDrawerGestureModeMask = MMOpenDrawerGestureMode.all
        drawerController?.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.all
        drawerController?.setDrawerVisualStateBlock( { drawerController, drawerSide, percentVisible in
            if percentVisible == 0 {
                Threads.showToolbar(animated: false)
            } else {
                Threads.hideToolbar(animated: false)
            }
        })
        
        window?.rootViewController = drawerController
        
        return true
        
    }
    
    func isProduction(pushApi: MFMSPushLite) -> Bool {
        return AppDelegate.isProduction()
    }
    
    func config(withPushApi pushApi: MFMSPushLite?) -> PushServerApiConfigDataSource? {
        let config = PushServerApiConfig()
        return config
    }
    
    func onPushMessagesReceived(pushApi: MFMSPushLite, messages: [PushNotificationMessage]) {
        for message in messages {
            let state: THRMessageRecieveState = Threads.didReceiveFullPush(message)
            if state == THRMessageRecieveStateAccepted {
                print("Full Push accepted by chat")
            } else {
                print("Full Push not accepted by chat")
            }
        }
    }
    
    func onError(pushApi PushApi: MFMSPushLite, error: String) {
        print("MFMSPushLite Error: \(error )")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        pushAPI?.appDelegate.didRegisterForRemoteNotifications(withDeviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        pushAPI?.appDelegate.didRegisterUserNotificationSettings(notificationSettings)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        pushAPI?.appDelegate.didFailToRegisterForRemoteNotifications(withError: error)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        pushAPI?.appDelegate.didReceiveRemoteNotification(userInfo)
        
        let state: THRMessageRecieveState = Threads.didReceiveShortPush(userInfo, handler: nil)
        if state == THRMessageRecieveStateAccepted {
            print("Short Push accepted by chat")
        } else {
            print("Short Push not accepted by chat")
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        pushAPI?.appDelegate.didReceiveRemoteNotification(userInfo, fetchCompletionHandler: { result in
            dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        let state = Threads.didReceiveShortPush(userInfo, handler: { result in
            dispatchGroup.leave()
        })
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            if state == THRMessageRecieveStateAccepted {
                print("Short Push accepted by chat")
            } else {
                print("Short Push not accepted by chat")
            }
            completionHandler(.newData)
        }
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        pushAPI?.appDelegate.didReceiveRemoteNotification(userInfo, fetchCompletionHandler: { result in
            dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        let state = Threads.didReceiveShortPush(userInfo, handler: { result in
            dispatchGroup.leave()
        })
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            if state == THRMessageRecieveStateAccepted {
                print("Short Push accepted by chat")
            } else {
                print("Short Push not accepted by chat")
            }
            completionHandler([])
        }
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        //Check if app was launched from notification tap
        if (response.actionIdentifier == UNNotificationDefaultActionIdentifier) {
            let pusDict = response.notification.request.content.userInfo
            let chatViewController = (tabBarController)?.viewControllers?[0].children.first as? ChatViewController
            chatViewController?.appLaunched(withNotification: pusDict)
        }
        
        completionHandler();
    }
    
    class func isProduction() -> Bool {
        let path = Bundle.main.path(forResource: "Info", ofType: "plist")
        let infoPlistDict = NSDictionary(contentsOfFile: path ?? "")
        let psConfig = infoPlistDict?["PS_API_CONFIG"] as? [AnyHashable : Any]
        return (psConfig?["PS_IS_PRODUCTION_SERVER"] as? NSNumber)?.boolValue ?? false
    }
    
    
    
}
