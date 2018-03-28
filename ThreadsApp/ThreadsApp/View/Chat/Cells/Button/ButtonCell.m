
//
//  ButtonCell.m
//  ThreadsApp
//
//  Created by Tabriz Dzhavadov on 13/07/2017.
//  Copyright © 2017 Brooma Service. All rights reserved.
//

#import "ButtonCell.h"

@interface ButtonCell()

@end

@implementation ButtonCell

- (void) awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void) construct {
    [self.button setTitle: [CellTypeHelper textByType: self.type] forState: UIControlStateNormal];
}

- (IBAction) clicked: (UIButton *) sender {
    if (self.delegate && [self.delegate respondsToSelector: @selector(buttonCellClicked:)]) {
        [self.delegate buttonCellClicked: self];
    }
}

@end
