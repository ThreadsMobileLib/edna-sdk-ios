//
//  IntegrationsViewController.h
//  ThreadsDemoObjc
//
//  Created by Vitaliy Kuzmenko on 25/07/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, Design) {
    DesignDefault,
    DesignAlternative,
};

@interface IntegrationsViewController : UITableViewController

- (void)pushChatInCurrentNavigationController;

- (void)pushChatInCurrentNavigationControllerWithHidingTabBar;

- (void)presentChatInUINavigationController;

- (void)presentChatUINavigationControllerAsTabInTabBarControllerInitializatedFromCode;

- (void)presentChatUINavigationControllerAsTabInTabBarControllerInitializatedFromStoryboard;

@end

NS_ASSUME_NONNULL_END
