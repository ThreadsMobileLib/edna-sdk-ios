//
//  ChatViewController.h
//  ThreadsApp
//
//  Created by Nikolay Kagala on 31/05/16.
//  Copyright © 2016 Brooma Service. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *chatContainer;
@property (weak, nonatomic) IBOutlet UICollectionView *clientsPager;
@property (weak, nonatomic) IBOutlet UIButton *addClient;

- (IBAction) addClientAction:(id)sender;

- (IBAction) showOrHideInput: (id) sender;

- (void) appLaunchedWithNotification: (NSDictionary*) notification;

@end
