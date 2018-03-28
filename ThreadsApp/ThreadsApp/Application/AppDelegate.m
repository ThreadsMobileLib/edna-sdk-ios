//
//  AppDelegate.m
//  ThreadsApp
//
//  Created by Nikolay Kagala on 31/05/16.
//  Copyright © 2016 Brooma Service. All rights reserved.
//

#import "AppDelegate.h"
#import <PushServerAPI/PushServerAPI-Swift.h>
#import <Threads/Threads.h>

#import <MMDrawerController.h>
#import <MMDrawerController/MMDrawerVisualState.h>

@interface AppDelegate ()
    
@property (nonatomic,strong) MMDrawerController * drawerController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (@available(iOS 10, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if(!error){
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    
    [Threads setDebugLoggingEnabled: YES];
    [PushServerAPI setPUSH_API_LOG_ENABLE: NO];
    [PushServerAPI showNetworkActivity: YES];
    [[PushServerAPI default] setOnPushMessagesReceived:^(NSArray<PushNotificationMessage *> *messages) {
        for(PushNotificationMessage *message in messages) {
            THRMessageRecieveState state = [Threads didReceiveFullPush: message];
            if(state == THRMessageRecieveStateAccepted) {
                NSLog(@"Full Push accepted by chat");
            } else {
                NSLog(@"Full Push not accepted by chat");
            }
        }
    }];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:[self class]]];
    UIViewController *centerController = [storyboard instantiateViewControllerWithIdentifier:@"CenterController"];
    UIViewController *drawerController = [storyboard instantiateViewControllerWithIdentifier:@"DrawerController"];
    
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:centerController rightDrawerViewController:drawerController];
    [self.drawerController setShowsShadow:NO];
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumRightDrawerWidth:200.0];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [self.drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        if(percentVisible == 0) {
            [Threads showToolbarAnimated:NO];
        }
        else {
            [Threads hideToolbarAnimated:NO];
        }
    }];
    
    [self.window setRootViewController:self.drawerController];
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[PushServerAPI default] didRegisterForRemoteNotificationsWithDeviceToken: deviceToken];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
    [[PushServerAPI default] didRegisterUserNotificationSettings: notificationSettings];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[PushServerAPI default] didReceiveRemoteNotification: userInfo];
    
    THRMessageRecieveState state = [Threads didReceiveShortPush: userInfo handler: nil];
    if(state == THRMessageRecieveStateAccepted) {
        NSLog(@"Short Push accepted by chat");
    } else {
        NSLog(@"Short Push not accepted by chat");
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [[PushServerAPI default] didReceiveRemoteNotification: userInfo
                                   fetchCompletionHandler: completionHandler];
    
    THRMessageRecieveState state = [Threads didReceiveShortPush: userInfo handler: completionHandler];
    if(state == THRMessageRecieveStateAccepted) {
        NSLog(@"Short Push accepted by chat");
    } else {
        NSLog(@"Short Push not accepted by chat");
    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    [[PushServerAPI default] didReceiveRemoteNotification:userInfo fetchCompletionHandler:^(UIBackgroundFetchResult result) {
        completionHandler(UNNotificationPresentationOptionNone);
    }];
    
    THRMessageRecieveState state = [Threads didReceiveShortPush: userInfo handler: ^(UIBackgroundFetchResult result) {
        completionHandler(UNNotificationPresentationOptionNone);
    }];
    
    if(state == THRMessageRecieveStateAccepted) {
        NSLog(@"Short Push accepted by chat");
    } else {
        NSLog(@"Short Push not accepted by chat");
    }
    
}

@end
