//
//  AboutViewController.h
//  ThreadsApp
//
//  Created by Brooma Service on 18/04/17.
//  Copyright © 2017 Brooma Service. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *counterLabel;

@property (nonatomic) NSInteger counterValue;

@end
