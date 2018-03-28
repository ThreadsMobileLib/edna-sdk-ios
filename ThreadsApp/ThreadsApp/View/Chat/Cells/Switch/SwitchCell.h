//
//  SwitchCell.h
//  ThreadsApp
//
//  Created by Tabriz Dzhavadov on 13/07/2017.
//  Copyright © 2017 Brooma Service. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellTypeHelper.h"

@class SwitchCell;

@protocol SwitchCellDelegate <NSObject>

@optional

- (void) switchCell: (SwitchCell *) cell switched: (BOOL) state;

@end

@interface SwitchCell : UITableViewCell

@property (weak, nonatomic) id <SwitchCellDelegate> delegate;

@property (assign, nonatomic) CellType type;

- (void) construct;

@end
