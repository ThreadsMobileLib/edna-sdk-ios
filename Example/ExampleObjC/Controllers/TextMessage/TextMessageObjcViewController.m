//
//  TextMessageObjcViewController.m
//  ExampleObjC
//
//  Created by Vitaliy Kuzmenko on 07/08/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import "TextMessageObjcViewController.h"
#import <Threads/Threads.h>

@interface TextMessageObjcViewController ()

@end

@implementation TextMessageObjcViewController

- (void)sendMessageWithText:(NSString *)text {
    [self startAnimating];
    __weak typeof(self) weakSelf = self;
    [[Threads threads] sendMessageWithText:text completion:^(NSError * _Nullable error) {
        [weakSelf stopAnimating];
        if (error) {
            [weakSelf presentFailedSubmissionOutsideMessageAlertWithError:error];
        } else {
            [weakSelf presentSuccessfulySubmitedOutsideMessageAlert];
        }
    }];
}

@end
