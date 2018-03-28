//
//  LabelCell.m
//  ThreadsApp
//
//  Created by Tabriz Dzhavadov on 13/07/2017.
//  Copyright © 2017 Brooma Service. All rights reserved.
//

#import "LabelCell.h"

@interface LabelCell()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation LabelCell

#pragma mark - Initialize

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - Configuring

- (void) construct {
    self.label.text = [CellTypeHelper textByType: self.type];
}

@end
