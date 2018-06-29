//
//  ClientCell.m
//  ThreadsApp
//
//  Created by Brooma Service on 27/10/2017.
//  Copyright © 2017 Brooma Service. All rights reserved.
//

#import "ClientCell.h"

@implementation ClientCell 

+ (NSString*) getReuseIdentifier {
    return @"ClientCell";
}

- (void) setClient:(Client *) client {
    _client = client;
    self.clientId.text = client.clientId;
    self.clientName.text = client.name;
    self.appMarker.text = client.appMarker;
}

- (Client*) getClient {
    return self.client;
}

- (IBAction)logout:(id)sender {
    [self.delegate logout:self.client];
}
@end
