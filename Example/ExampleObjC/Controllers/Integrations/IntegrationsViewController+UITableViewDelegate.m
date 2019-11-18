//
//  IntegrationsViewController+UITableViewDelegate.m
//  ThreadsDemoObjc
//
//  Created by Vitaliy Kuzmenko on 25/07/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import "IntegrationsViewController+UITableViewDelegate.h"

typedef NS_ENUM(NSInteger, IntegrationSection) {
    IntegrationSectionDesign,
    IntegrationSectionPush,
    IntegrationSectionPresent
};

typedef NS_ENUM(NSInteger, IntegrationPushSection) {
    IntegrationPushSectionPushWithTabBar,
    IntegrationPushSectionPushWithoutTabBar
};

typedef NS_ENUM(NSInteger, IntegrationPresentSection) {
    IntegrationPresentSectionPresent,
    IntegrationPresentSectionPresentInTabBar,
    IntegrationPresentSectionPresentInTabBarStoryboard
};

@implementation IntegrationsViewController (UITableViewDelegate)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case IntegrationSectionDesign:
            break;
        case IntegrationSectionPush:
            [self tableViewDidSelectPushSectionWithMethod:indexPath.row];
            break;
        case IntegrationSectionPresent:
            [self tableViewDidSelectPresentSectionWithMethod:indexPath.row];
            break;
    }
}

- (void)tableViewDidSelectPushSectionWithMethod:(IntegrationPushSection)method {
    switch (method) {
        case IntegrationPushSectionPushWithTabBar:
            [self pushChatInCurrentNavigationController];
            break;
        case IntegrationPushSectionPushWithoutTabBar:
            [self pushChatInCurrentNavigationControllerWithHidingTabBar];
            break;
    }
}

- (void)tableViewDidSelectPresentSectionWithMethod:(IntegrationPresentSection)method {
    switch (method) {
        case IntegrationPresentSectionPresent:
            [self presentChatInUINavigationController];
            break;
        case IntegrationPresentSectionPresentInTabBar:
            [self presentChatUINavigationControllerAsTabInTabBarControllerInitializatedFromCode];
            break;
        case IntegrationPresentSectionPresentInTabBarStoryboard:
            [self presentChatUINavigationControllerAsTabInTabBarControllerInitializatedFromStoryboard];
            break;
    }
}

@end
