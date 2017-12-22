//
//  ViewController.m
//  ThreadsApp
//
//  Created by Nikolay Kagala on 31/05/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "ViewController.h"
#import <Threads/Threads.h>
#import "EmptyViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *passField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"Threads Demo";
    self.phoneField.placeholder = NSLocalizedString(@"login_placeholder", @"");
    self.passField.placeholder = NSLocalizedString(@"password_placeholder", @"");
    self.nameField.placeholder = NSLocalizedString(@"name_placeholder", @"");
    [self.loginButton setTitle:NSLocalizedString(@"show_chat_title", @"") forState:UIControlStateNormal];
    self.phoneField.text = [Threads getLastClientId];
    self.nameField.text = [Threads getLastClientName];
    

}

- (IBAction) openChat:(id)sender {
    [self showChat];
}

- (void) showChat {
    [self.view endEditing:YES];
    if([self.phoneField.text isEqualToString:@""]){
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"input_login_alert", @"") message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    
    [self configureThreads];
    [self registerAndShow];
}

- (void) configureThreads {
    THRAttributes *attrs = [THRAttributes defaultAttributes];
    attrs.refreshColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
    
    attrs.navigationBarBackgroundColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
    attrs.navigationBarTintColor = [UIColor whiteColor];
    attrs.navigationBarTitleFont = [UIFont fontWithName:@"Lato-Semibold" size:18.f];
    attrs.navigationBarSubtitleFont = [UIFont fontWithName:@"Lato-Semibold" size:13.f];
    
    attrs.placeholderImage = [UIImage imageNamed:@"placeholder_image"];
    attrs.backgroundColor = [UIColor colorWithRed:234.f/255.f green:240.f/255.f blue:240.f/255.f alpha:1.f];
    attrs.placeholderTitleColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.7];
    attrs.placeholderSubtitleColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.5];
    attrs.placeholderTitleFont = [UIFont fontWithName:@"Lato-Semibold" size:19.f];
    attrs.placeholderSubtitleFont = [UIFont fontWithName:@"Lato-Regular" size:15.f];
    attrs.myMessageFont = [UIFont fontWithName:@"Lato-Regular" size:16.f];
    
    attrs.attachButtonColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
    attrs.attachButtonHighlightColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:0.7f];
    
    attrs.sendButtonColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
    attrs.sendButtonHighlightColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:0.7f];
    
    attrs.waitingSpecialistBorderColor = [UIColor clearColor];
    attrs.waitingSpecialistSpinnerColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
    
    attrs.outgoingBubbleColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
    attrs.outgoingBubbleTextColor = [UIColor whiteColor];
    attrs.failedBubbleColor = [UIColor colorWithRed:244.f/255.f green:67.f/255.f blue:54.f/255.f alpha:1.f];
    
    attrs.incomingBubbleTextColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];
    
    attrs.bubbleMessageFont = [UIFont fontWithName:@"Lato-Regular" size:17.f];
    attrs.bubbleTimeFont = [UIFont fontWithName:@"Lato-Regular" size:12.f];
    attrs.failedMessageFont = [UIFont fontWithName:@"Lato-Semibold" size:12.f];
    attrs.messageHeaderFont = [UIFont fontWithName:@"Lato-Semibold" size:13.f];
    
    attrs.specialisConnectTitleFont = [UIFont fontWithName:@"Lato-Semibold" size:17.f];
    attrs.specialisConnectSubtitleFont = [UIFont fontWithName:@"Lato-Regular" size:12.f];
    attrs.specialisConnectTitleColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];
    attrs.specialisConnectSubtitleColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];
    
    attrs.toolbarTintColor = [UIColor redColor];
    attrs.toolbarQuotedMessageAuthorFont = [UIFont fontWithName:@"Lato-Regular" size:17.f];
    attrs.toolbarQuotedMessageFont = [UIFont fontWithName:@"Lato-Light" size:17.f];
    attrs.toolbarQuotedMessageAuthorColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];
    attrs.toolbarQuotedMessageColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.5f];
    
    attrs.quoteAuthorFont = [UIFont fontWithName:@"Lato-Semibold" size:17.f];
    attrs.quoteMessageFont = [UIFont fontWithName:@"Lato-Light" size:17.f];
    attrs.quoteFilesizeFont = [UIFont fontWithName:@"Lato-Regular" size:13.f];
    attrs.quoteTimeFont = [UIFont fontWithName:@"Lato-Regular" size:13.f];
    
    attrs.outgoingQuoteSeparatorColor = [UIColor whiteColor];
    attrs.outgoingQuoteAuthorColor = [UIColor whiteColor];
    attrs.outgoingQuoteMessageColor = [UIColor whiteColor];
    attrs.outgoingQuoteTimeColor = [UIColor whiteColor];
    attrs.outgoingQuoteFilesizeColor = [UIColor whiteColor];
    
    attrs.incomingQuoteSeparatorColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
    attrs.incomingQuoteAuthorColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];
    attrs.incomingQuoteMessageColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.7f];
    attrs.incomingQuoteTimeColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.7f];
    attrs.incomingQuoteFilesizeColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.7f];
    attrs.incomingFileIconTintColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
    attrs.incomingFileIconBgColor = [UIColor colorWithRed:234.f/255.f green:240.f/255.f blue:240.f/255.f alpha:1.f];
    
    attrs.clearSearchIcon = [UIImage imageNamed:@"ic_clear_search"];
    attrs.searchBarTintColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];
    attrs.searchBarTextColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];
    attrs.searchBarTextFont = [UIFont fontWithName:@"Lato-Regular" size:14.f];
    attrs.searchScopeBarTintColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
    attrs.searchScopeBarFont = [UIFont fontWithName:@"Lato-Regular" size:13.f];
    
    attrs.findedMessageHeaderTextColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.5f];
    attrs.findedMessageHeaderBackgroundColor = [UIColor colorWithRed:234.f/255.f green:240.f/255.f blue:240.f/255.f alpha:1.f];
    attrs.findedMessageHeaderTextFont = [UIFont fontWithName:@"Lato-Regular" size:13.f];
    
    attrs.findMoreMessageTextColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];
    attrs.findMoreMessageTextFont = [UIFont fontWithName:@"Lato-Regular" size:15.f];

    attrs.searchMessageAuthorTextColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];;
    attrs.searchMessageTextColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.7f];
    attrs.searchMessageDateTextColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.7f];
    attrs.searchMessageFileTextColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.7f];
    attrs.searchMessageStatusTintColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
    attrs.searchMessageMatchTextColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];

    attrs.searchMessageAuthorTextFont = [UIFont fontWithName:@"Lato-Regular" size:17.f];
    attrs.searchMessageTextFont = [UIFont fontWithName:@"Lato-Regular" size:13.f];
    attrs.searchMessageFileTextFont = [UIFont fontWithName:@"Lato-Regular" size:13.f];
    attrs.searchMessageDateTextFont = [UIFont fontWithName:@"Lato-Regular" size:13.f];
    attrs.searchMessageMatchTextFont = [UIFont fontWithName:@"Lato-Medium" size:13.f];

    attrs.photoPickerCheckmarkIcon = [UIImage imageNamed:@"ic_checkmark"];
    
    attrs.photoPickerToolbarTintColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
    attrs.photoPickerToolbarButtonFont = [UIFont fontWithName:@"Lato-Regular" size:17.f];
    
    attrs.photoPickerSheetTextColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
    attrs.photoPickerSheetTextFont = [UIFont fontWithName:@"Lato-Regular" size:17.f];
    attrs.sendButtonFont = [UIFont fontWithName:@"Lato-Regular" size:17.f];
    
    attrs.messageBubbleFilledMaskImage = [UIImage imageNamed:@"rect_bubble_filled"];
    attrs.messageBubbleStrokedMaskImage = [UIImage imageNamed:@"rect_bubble_stroked"];
    
    attrs.typingText = @"печатает...";
    attrs.typingTextColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:0.5f];
    attrs.typingTextFont = [UIFont fontWithName:@"Lato-Medium" size:13.f];
    
    attrs.likeRatingColorEnabled = [UIColor orangeColor];
    attrs.starRatingColorEnabled = [UIColor redColor];
    attrs.likeRatingColorDisabled = [UIColor grayColor];
    attrs.starRatingColorDisabled = [UIColor grayColor];
    attrs.likeRatingColorCompleted = [UIColor whiteColor];
    attrs.starRatingColorCompleted = [UIColor yellowColor];
    attrs.scheduleIcon = [UIImage imageNamed:@"schedule_alert"];
    attrs.scheduleAlertFont = [UIFont fontWithName:@"Lato-Semibold" size:17.f];
    attrs.scheduleAlertColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];
    
    attrs.likeLabelOnStarColor = [UIColor colorWithRed:131.f/255.f green:177.f/255.f blue:67.f/255.f alpha:1.f];
    attrs.likeLabelUnderStarColor = [UIColor whiteColor];
    
    [Threads clearCachedFiles];
    [Threads setAttributes:attrs];
    [Threads setClientId:self.phoneField.text];
    [Threads setCryptedToken:[Threads threads].clientId];
    if([self.nameField.text isEqualToString:@""]){
        [Threads setClientName:self.phoneField.text];
    } else {
        [Threads setClientName:self.nameField.text];
    }
    
}

- (void) registerAndShow {
    self.loginButton.enabled = NO;
    [Threads registerClientWithCompletion:^(BOOL state, NSError *error) {
        self.loginButton.enabled = YES;
        NSLog(@"%@", error);
        if (state) {
            [Threads showInView:_containerView parentController:self bottomSpacing:self.tabBarController.tabBar.frame.size.height];
            [self.view bringSubviewToFront:_containerView];
            [[Threads threads] setUnreadedMessagesCountChanged:^(NSInteger messagesCount) {
                UINavigationController *navController = self.tabBarController.viewControllers.lastObject;
                EmptyViewController *emp = navController.viewControllers.firstObject;
                emp.counterLabel.text = [NSString stringWithFormat:@"%ld", (long)messagesCount];
            }];
        }
        else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Registration failed. Retry?" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self registerAndShow];
            }];
            UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:actionOk];
            [alert addAction:actionCancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}


@end
