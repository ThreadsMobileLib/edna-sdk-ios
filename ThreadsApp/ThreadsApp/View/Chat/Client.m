//
//  Client.m
//  ThreadsApp
//
//  Created by Brooma Service on 27/10/2017.
//  Copyright © 2017 Brooma Service. All rights reserved.
//

#import "Client.h"
#import "DictUtils.h"

@implementation Client

static NSString* kClientIdKey               = @"client_id";
static NSString* kClientNameKey             = @"client_name";

+ (instancetype) clientWithId: (NSString*) clientId name: (NSString*) name {
    Client* client = [Client alloc];
    client.clientId = clientId;
    client.name = name;
    
    return client;
}

+ (instancetype) initWithJson: (NSDictionary*) json {
    Client* client = [Client alloc];
    client.clientId = [DictUtils getStringFrom:json byKey:kClientIdKey];
    client.name = [DictUtils getStringFrom:json byKey:kClientNameKey];
    
    return client;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.clientId forKey: kClientIdKey];
    [aCoder encodeObject:self.name forKey: kClientNameKey];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [self init]) {
        self.clientId = [aDecoder decodeObjectForKey: kClientIdKey];
        self.name = [aDecoder decodeObjectForKey: kClientNameKey];
    }
    return self;
}

@end
