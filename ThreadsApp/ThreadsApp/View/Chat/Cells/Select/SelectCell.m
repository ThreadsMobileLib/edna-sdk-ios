//
//  SelectCell.m
//  ThreadsApp
//
//  Created by Tabriz Dzhavadov on 13/07/2017.
//  Copyright © 2017 Sequenia. All rights reserved.
//

#import "SelectCell.h"
#import "SelectViewController.h"

@interface SelectCell()

@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;

@end

@implementation SelectCell

- (void) awakeFromNib {
    [super awakeFromNib];
}

- (void) construct {
    self.placeholderLabel.text = [CellTypeHelper textByType: self.type];
    self.mainLabel.text = [[self class] designName: self.selectedDesign];
}

- (void) showDesignControllerIn: (UIViewController *) controller
                        designs: (NSArray <NSNumber *> *) designs {
    SelectViewController *selectVC = [SelectViewController new];
    selectVC.selects = designs;
    selectVC.delegate = self.delegate;
    
    UINavigationController *nav = [UINavigationController new];
    nav.viewControllers = @[selectVC];
    
    [controller presentViewController: nav animated: YES completion: nil];
}

+ (NSString *) designName: (THRDesign) design {
    if (design == THRDesignBRS)
        return @"BRS";
    else
        return @"Default";
}

+ (NSArray <NSNumber *> *) allDesigns {
    NSMutableArray <NSNumber *> *designs = [@[] mutableCopy];
    for (THRDesign design = 0; design < THRDesignCount; design++) {
        [designs addObject: @(design)];
    }
    return designs.copy;
}

@end
