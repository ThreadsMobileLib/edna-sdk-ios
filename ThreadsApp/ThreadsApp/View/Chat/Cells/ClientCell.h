//
//  ClientCell.h
//  ThreadsApp
//
//  Created by Brooma Service on 27/10/2017.
//  Copyright © 2017 Brooma Service. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "Client.h"

@protocol ClientCellDelegate

@required
- (void) logout: (Client*) client;

@end

@interface ClientCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *clientId;
@property (weak, nonatomic) IBOutlet UILabel *clientName;
@property (weak, nonatomic) IBOutlet UILabel *appMarker;
@property (weak, nonatomic) IBOutlet UILabel *clientIdSignature;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@property (nonatomic) Client* client;
@property (nonatomic, weak) id<ClientCellDelegate> delegate;

- (IBAction)logout:(id)sender;
- (Client*) getClient;

+ (NSString*) getReuseIdentifier;


@end
