//
//  ButtonCell.h
//  ThreadsApp
//
//  Created by Tabriz Dzhavadov on 13/07/2017.
//  Copyright © 2017 Sequenia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellTypeHelper.h"

@class ButtonCell;

@protocol ButtonCellDelegate <NSObject>

@optional

- (void) buttonCellClicked: (ButtonCell *) cell;

@end

@interface ButtonCell : UITableViewCell

@property (weak, nonatomic) id <ButtonCellDelegate> delegate;

@property (assign, nonatomic) CellType type;

@property (weak, nonatomic) IBOutlet UIButton *button;

- (void) construct;

@end
