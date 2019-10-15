//
//  AppDelegate.m
//  ThreadsDemoObjc
//
//  Created by Vitaliy Kuzmenko on 22/07/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import "AppDelegate.h"
#import <MFMSPushLite/MFMSPushLite.h>
#import <Threads/Threads.h>
#import "UserNotifications/UserNotifications.h"
#import "SignatureService.h"
#import "MainViewController.h"
#import "Configuration.h"

@interface AppDelegate () <UNUserNotificationCenterDelegate, ThreadsDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Step 1: Configure Threads Framework
    [self configureThreads];
    
    // Step 2: Register device for remote notifications
    [self registerForRemoteNotifications];
    
    // Step 3: (Only for Demo App) Configure SignatureService for receiving client signature form server.
    [self configureSignatureService];
    
    return YES;
}

#pragma mark - Application Setup Configuration

- (void)configureThreads {
    Threads *threads = [Threads threads];
    threads.isDebugLoggingEnabled = YES;
    threads.isClientIdEncrypted = NO;
    threads.isShowsNetworkActivity = YES;
    
    [threads configureWithDelegate:self
              productionMFMSServer:YES
                        historyURL:[NSURL URLWithString:@"<#HISTORY_URL#>"]
                  fileUploadingURL:[NSURL URLWithString:@"<#FILE_UPLOADING_URL#>"]];
}

/**
 Register device for APNS push notifications for transport messages
 */
- (void)registerForRemoteNotifications {
    if (@available(iOS 10, *)) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    }
    [[Threads threads] registerApplicationForRemoteNotificationsStandartOptionsWithAuthorizationStatusDenied:^{
        NSLog(@"Remote notifications denied");
    } completionHandler:^(NSData * _Nullable deviceToken) {
        NSLog(@"Application registered for remote notifications %@", deviceToken);
    }];
}

- (void)configureSignatureService {
    [SignatureService sharedInstance].serverURL = [NSURL URLWithString:@"<#SIGNATURE_URL#>"];
}

#pragma mark - Remote Notifications

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [[Threads threads] applicationDidRegisterUserNotificationSettings:notificationSettings];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[Threads threads] applicationDidRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [[Threads threads] applicationDidFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[Threads threads] applicationDidReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [[Threads threads] applicationDidReceiveRemoteNotification:userInfo fetchCompletionHandler:^(THRMessageRecieveState state) {
        completionHandler(UIBackgroundFetchResultNewData);
    }];
}

- (void)handleOpeningFromPushWithUserInfo:(NSDictionary *)userInfo {
    if ([[Threads threads] isThreadsOriginPushUserInfo:userInfo]) {
        // Application launched from Threads notification
        NSString *appMarker = [[Threads threads] getAppMarkerFromPushUserInfo:userInfo];
        MainViewController *vc = (MainViewController *)self.window.rootViewController;
        [vc showChatForAppMarker:appMarker];
    } else {
        // Application launched from other notifications
    }
}

#pragma mark - UNUserNotificationCenterDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler API_AVAILABLE(ios(10.0)){
    [[Threads threads] applicationDidReceiveRemoteNotification:notification.request.content.userInfo fetchCompletionHandler:^(THRMessageRecieveState state) {
        completionHandler(UNNotificationPresentationOptionNone);
    }];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    // Check for application launched from notification
    if ([response.actionIdentifier isEqualToString: UNNotificationDefaultActionIdentifier]) {
        NSDictionary *userInfo = response.notification.request.content.userInfo;
        [self handleOpeningFromPushWithUserInfo:userInfo];
    }
    completionHandler();
}

- (void)threads:(nonnull Threads *)threads didReceiveFullMessages:(nonnull NSArray<PushNotificationMessage *> *)messages {
    // Use this delegate method for access to received full data messages
}

- (void)threads:(Threads *)threads unreadMessagesCount:(NSUInteger)unreadMessagesCount {
    MainViewController *vc = (MainViewController *)self.window.rootViewController;
    [vc setUnreadMessagesCount:unreadMessagesCount];
}

- (void)threads:(Threads *)threads didReceiveError:(NSError *)error {
    NSLog(@"Threads received error = %@", error.localizedDescription);
}

@end
