//
//  TextCell.m
//  ThreadsApp
//
//  Created by Tabriz Dzhavadov on 13/07/2017.
//  Copyright © 2017 Sequenia. All rights reserved.
//

#import "TextCell.h"

@interface TextCell()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation TextCell

#pragma mark - Initialize

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - Configuring

- (void) construct {
    self.textField.placeholder = [CellTypeHelper textByType: self.type];
    [self.textField addTarget: self
                       action: @selector(textFieldChanged:)
             forControlEvents: UIControlEventEditingChanged];
}

- (void) setText:(NSString *)text {
    [self.textField setText: text];
    [self textFieldChanged: self.textField];
}

- (NSString *) text {
    return self.textField.text;
}

- (void) textFieldChanged: (UITextField *) textField {
    if (self.delegate && [self.delegate respondsToSelector: @selector(textCell:textChanged:)]) {
        [self.delegate textCell: self textChanged: textField.text];
    }
}

@end
