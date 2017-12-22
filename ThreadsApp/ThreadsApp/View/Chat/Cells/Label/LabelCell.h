//
//  LabelCell.h
//  ThreadsApp
//
//  Created by Tabriz Dzhavadov on 13/07/2017.
//  Copyright © 2017 Sequenia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellTypeHelper.h"

@interface LabelCell : UITableViewCell

@property (assign, nonatomic) CellType type;

- (void) construct;

@end
