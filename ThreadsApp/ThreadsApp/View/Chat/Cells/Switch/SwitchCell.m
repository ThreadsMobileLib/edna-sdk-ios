//
//  SwitchCell.m
//  ThreadsApp
//
//  Created by Tabriz Dzhavadov on 13/07/2017.
//  Copyright © 2017 Brooma Service. All rights reserved.
//

#import "SwitchCell.h"

@interface SwitchCell()

@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;

@property (weak, nonatomic) IBOutlet UISwitch *switcher;

@end

@implementation SwitchCell

#pragma mark - Initialize

- (void) awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - Configuring

- (void) construct {
    self.placeholderLabel.text = [CellTypeHelper textByType: self.type];
}

- (IBAction) switched: (UISwitch *) sender {
    if (self.delegate && [self.delegate respondsToSelector: @selector(switchCell:switched:)]) {
        [self.delegate switchCell: self switched: self.switcher.isOn];
    }
}

@end
