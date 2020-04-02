//
//  MainViewController.m
//  ThreadsDemoObjc
//
//  Created by Vitaliy Kuzmenko on 22/07/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import "MainViewController.h"

typedef NS_ENUM(NSInteger, MainViewControllerTab) {
    MainViewControllerTabClients,
    MainViewControllerTabIntegrations,
    MainViewControllerTabUtilites,
};

@interface MainViewController () <UITabBarControllerDelegate>

@property (nonatomic, copy, nullable) NSString *unreadMessagesBadgeValue;

- (void)updateUnreadMessagesCountBadgeValue;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
}

- (void)setUnreadMessagesCount:(NSUInteger)unreadMessagesCount {
    self.unreadMessagesBadgeValue = unreadMessagesCount ? [NSString stringWithFormat:@"%lu", (unsigned long)unreadMessagesCount] : nil;
    [self updateUnreadMessagesCountBadgeValue];
}

- (void)updateUnreadMessagesCountBadgeValue {
    UITabBarItem *tabBarItem = self.viewControllers[MainViewControllerTabIntegrations].tabBarItem;
    UINavigationController *nc = (UINavigationController *)self.selectedViewController;
    
    if (self.selectedIndex != MainViewControllerTabIntegrations || [nc.visibleViewController conformsToProtocol:@protocol(IntegrationsProtocol)]) {
        tabBarItem.badgeValue = self.unreadMessagesBadgeValue;
    } else {
        tabBarItem.badgeValue = nil;
    }
}

#pragma mark - Show Chat from Notification

- (void)showChatForAppMarker:(NSString *)appMarker {
    self.selectedIndex = 1;
    UINavigationController *nvc = (UINavigationController *)self.viewControllers[1];
    UIViewController <IntegrationsProtocol> *vc = (UIViewController <IntegrationsProtocol> *) nvc.viewControllers[0];
    NSInteger design = [appMarker hasSuffix:@"CRG"] ? 1 : 0;
    [vc presentFromPushWithDesign:design];
}

#pragma mark - UITabBarDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    [self updateUnreadMessagesCountBadgeValue];
}

@end
