//
//  ChatFragmentViewController.m
//  ThreadsApp - Polarbear
//
//  Created by Brooma Service on 28/05/2018.
//  Copyright © 2018 Brooma Service. All rights reserved.
//

#import "ChatFragmentViewController.h"
#import <Threads/Threads.h>

@interface ChatFragmentViewController ()

@end

@implementation ChatFragmentViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self registerDeviceOrientationNotification: YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self registerDeviceOrientationNotification: NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) registerDeviceOrientationNotification: (BOOL) state {
    if (state)
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(orientationChanged:)
                                                     name: UIDeviceOrientationDidChangeNotification
                                                   object: nil];
    else
        [[NSNotificationCenter defaultCenter] removeObserver: self
                                                        name: UIDeviceOrientationDidChangeNotification
                                                      object: nil];
}

- (void) orientationChanged: (NSNotification *) notification {
    [Threads setMessageInputInset:self.tabBarController.tabBar.frame.size.height animated:NO];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
