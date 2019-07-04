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
static NSString* kClientIdSignatureKey             = @"client_id_signature";

+ (instancetype) clientWithId: (NSString*) clientId name: (NSString*) name appMarker:(NSString*) appMarker clientIdsignature:(NSString*) clientIdSignature {
    Client* client = [Client alloc];
    client.clientId = clientId;
    client.name = name;
    client.appMarker = appMarker;
    client.clientIdSignature = clientIdSignature;
    
    return client;
}

+ (instancetype) initWithJson: (NSDictionary*) json {
    Client* client = [Client alloc];
    client.clientId = [DictUtils getStringFrom:json byKey:kClientIdKey];
    client.name = [DictUtils getStringFrom:json byKey:kClientNameKey];
    client.appMarker = [DictUtils getStringFrom:json byKey:kClientAppMarkerKey];
    client.clientIdSignature = [DictUtils getStringFrom:json byKey:kClientIdSignatureKey];
    
    return client;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.clientId forKey: kClientIdKey];
    [aCoder encodeObject:self.name forKey: kClientNameKey];
    [aCoder encodeObject:self.appMarker forKey: kClientAppMarkerKey];
    [aCoder encodeObject:self.clientIdSignature forKey: kClientIdSignatureKey];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [self init]) {
        self.clientId = [aDecoder decodeObjectForKey: kClientIdKey];
        self.name = [aDecoder decodeObjectForKey: kClientNameKey];
        self.appMarker = [aDecoder decodeObjectForKey: kClientAppMarkerKey];
        self.clientIdSignature = [aDecoder decodeObjectForKey: kClientIdSignatureKey];
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    
    if ([super isEqual: object]) {
        return YES;
    } else if (![object isKindOfClass:[self class]]) {
        return NO;
    } else {
        Client* item = (Client*) object;
        return [self.clientId isEqualToString: item.clientId]
        && [self.appMarker isEqualToString: item.appMarker]
        && [self.clientIdSignature isEqualToString: item.clientIdSignature]
        && [self.name isEqualToString: item.name];
    }
}

- (NSUInteger)hash {
    return self.clientId.hash ^ self.appMarker.hash ^ self.clientIdSignature.hash ^ self.name.hash;
}

@end
