//
//  SelectCell.h
//  ThreadsApp
//
//  Created by Tabriz Dzhavadov on 13/07/2017.
//  Copyright © 2017 Brooma Service. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellTypeHelper.h"

@class SelectCell;

typedef enum : NSUInteger {
    THRDesignDefault,
    THRDesignBRS,
    THRDesignCount
} THRDesign;

@protocol SelectCellDelegate <NSObject>

@optional

- (void) selectCellDidSelect: (THRDesign) design;

@end

@interface SelectCell : UITableViewCell

@property (weak, nonatomic) id <SelectCellDelegate> delegate;

@property (assign, nonatomic) CellType type;

@property (assign, nonatomic) THRDesign selectedDesign;

- (void) construct;

- (void) showDesignControllerIn: (UIViewController *) controller
                        designs: (NSArray <NSNumber *> *) designs;

+ (NSString *) designName: (THRDesign) design;

+ (NSArray <NSNumber *> *) allDesigns;

@end
