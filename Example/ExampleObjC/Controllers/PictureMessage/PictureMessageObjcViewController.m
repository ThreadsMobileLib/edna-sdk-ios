//
//  PictureMessageObjcViewController.m
//  ExampleObjC
//
//  Created by Vitaliy Kuzmenko on 07/08/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import "PictureMessageObjcViewController.h"
#import <Threads/Threads.h>

@interface PictureMessageObjcViewController ()

@end

@implementation PictureMessageObjcViewController

- (void)sendOutsideImageMessageWithImage:(UIImage *)image {
    [self startAnimating];
    __weak typeof(self) weakSelf = self;
    [[Threads threads] sendMessageWithImage:image completion:^(NSError * _Nullable error) {
        [weakSelf stopAnimating];
        if (error) {
            [weakSelf presentFailedSubmissionOutsideMessageAlertWithError:error];
        } else {
            [weakSelf presentSuccessfulySubmitedOutsideMessageAlert];
        }
    }];
}

@end
