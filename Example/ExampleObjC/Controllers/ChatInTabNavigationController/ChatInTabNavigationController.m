//
//  ChatInTabNavigationController.m
//  ThreadsDemoObjc
//
//  Created by Vitaliy Kuzmenko on 25/07/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import "ChatInTabNavigationController.h"
#import <Threads/Threads.h>
#import "AttributesHelper.h"

@implementation ChatInTabNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewControllers = @[[self getChatViewController]];
}

- (THRAttributes *)getAttributes {
    switch (self.design) {
        case DesignDefault:
            return [AttributesHelper getDefaultAttributes];
        case DesignAlternative:
            return [AttributesHelper getAltAttributes];
    }
}

- (UIViewController *)getChatViewController {
    THRAttributes *attributes = [self getAttributes];
    UIViewController *chatViewController = [[Threads threads] chatViewControllerWithAttributes:attributes];
    return chatViewController;
}

@end
