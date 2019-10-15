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

@interface IntegrationsViewController : UIViewController

- (void)pushChatInCurrentNavigationController;

- (void)presentFromPushWithDesign:(NSInteger)design;

@end

@interface MainViewController () <UITabBarControllerDelegate>

@property (nonatomic, copy, nullable) NSString *unreadMessagesBadgeValue;

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
    tabBarItem.badgeValue = self.selectedIndex == MainViewControllerTabIntegrations ? nil : self.unreadMessagesBadgeValue;
}

#pragma mark - Show Chat from Notification

- (void)showChatForAppMarker:(NSString *)appMarker {
    self.selectedIndex = 1;
    UINavigationController *nvc = (UINavigationController *)self.viewControllers[1];
    IntegrationsViewController *vc = nvc.viewControllers[0];
    NSInteger design = [appMarker hasSuffix:@"CRG"] ? 1 : 0;
    [vc presentFromPushWithDesign:design];    
}

#pragma mark - UITabBarDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    [self updateUnreadMessagesCountBadgeValue];
}

@end
