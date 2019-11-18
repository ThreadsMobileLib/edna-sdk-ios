//
//  ChatInTabNavigationController.m
//  ThreadsDemoObjc
//
//  Created by Vitaliy Kuzmenko on 25/07/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import "ChatInTabNavigationController.h"
#import <Threads/Threads.h>

@implementation ChatInTabNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewControllers = @[[self getChatViewController]];
}

- (THRAttributes *)getAttributes {
    THRAttributes *attributes = [[THRAttributes alloc] init];
    return attributes;
}

- (UIViewController *)getChatViewController {
    THRAttributes *attributes = [self getAttributes];
    UIViewController *chatViewController = [[Threads threads] chatViewControllerWithAttributes:attributes];
    return chatViewController;
}

@end
