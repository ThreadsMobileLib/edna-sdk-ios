//
//  ClientTableViewCell.m
//  ThreadsDemoObjc
//
//  Created by Vitaliy Kuzmenko on 23/07/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import "ClientTableViewCell.h"
#import "Client.h"

@interface ClientTableViewCell()

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *idLabel;

@property (strong, nonatomic) IBOutlet UILabel *signatureLabel;

@end

@implementation ClientTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureForClient:(Client *)client {
    self.idLabel.text = client.id;
    self.nameLabel.text = [self getClientNameForClient:client];
    self.signatureLabel.text = [self getClientSignatureForClient:client];
}

- (NSString *)getClientNameForClient:(Client *)client {
    if (client.name.length) {
        return client.name;
    } else {
        return NSLocalizedString(@"No Name", "");
    }
}

- (NSString *)getClientSignatureForClient:(Client *)client {
    if (client.signature.length) {
        return client.signature;
    } else {
        return NSLocalizedString(@"Signature is missing", "");
    }
}

@end
