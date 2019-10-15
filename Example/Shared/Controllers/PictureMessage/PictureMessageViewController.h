//
//  PictureMessageViewController.h
//  ThreadsDemoObjc
//
//  Created by Vitaliy Kuzmenko on 31/07/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PictureMessageViewController : UITableViewController

- (void)startAnimating;

- (void)stopAnimating;

- (void)presentSuccessfulySubmitedOutsideMessageAlert;

- (void)presentFailedSubmissionOutsideMessageAlertWithError:(NSError *)error;

- (void)sendOutsideImageMessageWithImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
