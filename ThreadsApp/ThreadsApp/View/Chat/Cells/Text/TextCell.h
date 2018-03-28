//
//  TextCell.h
//  ThreadsApp
//
//  Created by Tabriz Dzhavadov on 13/07/2017.
//  Copyright © 2017 Brooma Service. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellTypeHelper.h"

@class TextCell;

@protocol TextCellDelegate <NSObject>

@optional

- (void) textCell: (TextCell *) cell textChanged: (NSString *) text;

@end

@interface TextCell : UITableViewCell

@property (weak, nonatomic) id <TextCellDelegate> delegate;

@property (assign, nonatomic) CellType type;

- (void) construct;

- (void) setText: (NSString *) text;

- (NSString *) text;

@end
