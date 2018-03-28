//
//  SelectViewController.h
//  ThreadsApp
//
//  Created by Tabriz Dzhavadov on 13/07/2017.
//  Copyright © 2017 Brooma Service. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectCell.h"

@interface SelectViewController : UIViewController

@property (strong, nonatomic) NSArray <NSNumber *> *selects;

@property (weak, nonatomic) id <SelectCellDelegate> delegate;

@end
