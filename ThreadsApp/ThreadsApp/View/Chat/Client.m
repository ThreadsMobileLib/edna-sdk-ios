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
static NSString* kClientAppMarkerKey             = @"app_marker";

+ (instancetype) clientWithId: (NSString*) clientId name: (NSString*) name appMarker:(NSString*) appMarker {
    Client* client = [Client alloc];
    client.clientId = clientId;
    client.name = name;
    client.appMarker = appMarker;
    
    return client;
}

+ (instancetype) initWithJson: (NSDictionary*) json {
    Client* client = [Client alloc];
    client.clientId = [DictUtils getStringFrom:json byKey:kClientIdKey];
    client.name = [DictUtils getStringFrom:json byKey:kClientNameKey];
    client.appMarker = [DictUtils getStringFrom:json byKey:kClientAppMarkerKey];
    
    return client;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.clientId forKey: kClientIdKey];
    [aCoder encodeObject:self.name forKey: kClientNameKey];
    [aCoder encodeObject:self.appMarker forKey: kClientAppMarkerKey];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [self init]) {
        self.clientId = [aDecoder decodeObjectForKey: kClientIdKey];
        self.name = [aDecoder decodeObjectForKey: kClientNameKey];
        self.appMarker = [aDecoder decodeObjectForKey: kClientAppMarkerKey];
    }
    return self;
}

@end
