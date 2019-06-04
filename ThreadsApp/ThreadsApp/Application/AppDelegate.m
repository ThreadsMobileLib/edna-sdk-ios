//
//  AppDelegate.m
//  ThreadsApp
//
//  Created by Nikolay Kagala on 31/05/16.
//  Copyright © 2016 Brooma Service. All rights reserved.
//

#import "AppDelegate.h"
#import <MFMSPushLite/MFMSPushLite.h>
#import <Threads/Threads.h>

#import "ChatViewController.h"
#import <MMDrawerController/MMDrawerController.h>
#import <MMDrawerController/MMDrawerVisualState.h>

@interface AppDelegate () <MFMSPushLiteDelegate>

@property (nonatomic,strong) MMDrawerController * drawerController;
@property (nonatomic,strong) UITabBarController * tabBarController;
@property MFMSPushLite* pushAPI;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (@available(iOS 10, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if(!error){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                });
            }
        }];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    
    [Threads setDebugLoggingEnabled: YES];
    [PushServerAPI setPUSH_API_LOG_ENABLE: NO];
    [PushServerAPI showNetworkActivity: YES];
    
    self.pushAPI = [[MFMSPushLite alloc] initWithDelegate:self];
    self.pushAPI.autoRegisterForNotification = false;
    [self.pushAPI start];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle bundleForClass:[self class]]];
    self.tabBarController = [storyboard instantiateViewControllerWithIdentifier:@"CenterController"];
    UIViewController *drawerController = [storyboard instantiateViewControllerWithIdentifier:@"DrawerController"];
    
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:self.tabBarController rightDrawerViewController:drawerController];
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

- (BOOL)isProductionWithPushApi:(MFMSPushLite * _Nonnull)pushApi {
    return [AppDelegate isProduction];
}

- (id<PushServerApiConfigDataSource>)configWithPushApi:(MFMSPushLite *)pushApi {
    PushServerApiConfig* config = [PushServerApiConfig new];
    return config;
}

-(void)onPushMessagesReceivedWithPushApi:(MFMSPushLite *)PushApi messages:(NSArray<PushNotificationMessage *> *)messages{
    for(PushNotificationMessage *message in messages) {
        THRMessageRecieveState state = [Threads didReceiveFullPush: message];
        if(state == THRMessageRecieveStateAccepted) {
            NSLog(@"Full Push accepted by chat");
        } else {
            NSLog(@"Full Push not accepted by chat");
        }
    }
}

-(void)onErrorWithPushApi:(MFMSPushLite *)PushApi error:(NSString *)error{
    NSLog(@"MFMSPushLite Error: %@", error);
}
 
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [self.pushAPI.appDelegate didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [self.pushAPI.appDelegate didRegisterUserNotificationSettings:notificationSettings];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    [self.pushAPI.appDelegate didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [self.pushAPI.appDelegate didReceiveRemoteNotification:userInfo];
    
    THRMessageRecieveState state = [Threads didReceiveShortPush: userInfo handler: nil];
    if(state == THRMessageRecieveStateAccepted) {
        NSLog(@"Short Push accepted by chat");
    } else {
        NSLog(@"Short Push not accepted by chat");
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    dispatch_group_t dispatchGroup = dispatch_group_create();
    
    dispatch_group_enter(dispatchGroup);
    [self.pushAPI.appDelegate didReceiveRemoteNotification: userInfo fetchCompletionHandler: ^(UIBackgroundFetchResult result) {
        dispatch_group_leave(dispatchGroup);
    }];
    
    dispatch_group_enter(dispatchGroup);
    THRMessageRecieveState state = [Threads didReceiveShortPush: userInfo handler: ^(UIBackgroundFetchResult result) {
        dispatch_group_leave(dispatchGroup);
    }];
    
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^{
        if(state == THRMessageRecieveStateAccepted) {
            NSLog(@"Short Push accepted by chat");
        } else {
            NSLog(@"Short Push not accepted by chat");
        }
        completionHandler(UIBackgroundFetchResultNewData);
    });
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    dispatch_group_t dispatchGroup = dispatch_group_create();
    
    dispatch_group_enter(dispatchGroup);
    [self.pushAPI.appDelegate didReceiveRemoteNotification:userInfo fetchCompletionHandler:^(UIBackgroundFetchResult result) {
        dispatch_group_leave(dispatchGroup);
    }];
    
    dispatch_group_enter(dispatchGroup);
    THRMessageRecieveState state = [Threads didReceiveShortPush: userInfo handler: ^(UIBackgroundFetchResult result) {
        dispatch_group_leave(dispatchGroup);
    }];
    
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^{
        if(state == THRMessageRecieveStateAccepted) {
            NSLog(@"Short Push accepted by chat");
        } else {
            NSLog(@"Short Push not accepted by chat");
        }
        completionHandler(UNNotificationPresentationOptionNone);
    });
}

- (void) userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    
    //Check if app was launched from notification tap
    if ([response.actionIdentifier isEqualToString: UNNotificationDefaultActionIdentifier]) {
        NSDictionary* pusDict = response.notification.request.content.userInfo;
        ChatViewController* chatViewController = (ChatViewController*) ((UITabBarController*) self.tabBarController).viewControllers[0].childViewControllers.firstObject;
        [chatViewController appLaunchedWithNotification: pusDict];
    }
    completionHandler();
}

+ (BOOL) isProduction {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *infoPlistDict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSDictionary *psConfig = [infoPlistDict objectForKey:@"PS_API_CONFIG"];
    return [[psConfig objectForKey:@"PS_IS_PRODUCTION_SERVER"] boolValue];
}

@end
