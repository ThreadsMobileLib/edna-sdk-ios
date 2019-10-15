//
//  TextMessageViewController.m
//  ThreadsDemoObjc
//
//  Created by Vitaliy Kuzmenko on 31/07/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import "TextMessageViewController.h"

@interface TextMessageViewController ()

@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *sendBarButton;

@end

@implementation TextMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.textView becomeFirstResponder];
}

- (IBAction)sendMessage:(id)sender {
    NSString *text = self.textView.text;
    if (!text.length) {
        return;
    }
    [self sendMessageWithText:text];
}

- (void)sendMessageWithText:(NSString *)text {
    
}

- (void)presentSuccessfulySubmitedOutsideMessageAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Success", "")
                                                                   message:NSLocalizedString(@"Your message successfuly submited.", "")
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        self.textView.text = nil;
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)presentFailedSubmissionOutsideMessageAlertWithError:(NSError *)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Failed", "")
                                                                   message:error.userInfo[@"error_description"]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)startAnimating {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.activityView];
    self.navigationItem.rightBarButtonItem = item;
    [self.activityView startAnimating];
    [self.view endEditing:YES];
    self.view.userInteractionEnabled = NO;
}

- (void)stopAnimating {
    [self.activityView stopAnimating];
    self.navigationItem.rightBarButtonItem = self.sendBarButton;
    self.view.userInteractionEnabled = YES;
}

@end
