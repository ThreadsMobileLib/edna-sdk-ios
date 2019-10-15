//
//  User.m
//  ThreadsDemoObjc
//
//  Created by Vitaliy Kuzmenko on 23/07/2019.
//  Copyright © 2019 Threads. All rights reserved.
//

#import "Client.h"

@implementation Client

static NSString *kIdKey                 = @"client_id";
static NSString *kClientNameKey         = @"client_name";
static NSString *kClientAppMarkerKey    = @"app_marker";
static NSString *kSignatureKey          = @"client_id_signature";

+ (instancetype)clientWithId:(NSString *)id name:(NSString *)name appMarker:(NSString *)appMarker signature:(NSString *)signature {
    Client *client = [[Client alloc] init];
    client.id = id;
    client.name = name;
    client.appMarker = appMarker;
    client.signature = signature;
    return client;
}

- (BOOL)isEqual:(id)object {
    if ([super isEqual: object]) {
        return YES;
    } else if ([object isKindOfClass:[self class]]) {
        Client *item = (Client *)object;
        return [self.id isEqualToString:item.id]
        && [self.appMarker isEqualToString:item.appMarker]
        && [self.signature isEqualToString:item.signature]
        && [self.name isEqualToString:item.name];
    } else {
        return NO;
    }
}

- (NSUInteger)hash {
    return self.id.hash ^ self.appMarker.hash ^ self.signature.hash ^ self.name.hash;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Client Id:%@, Name:%@, AppMarker:%@, Signature:%@", self.id, self.name, self.appMarker, self.signature];
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.id forKey: kIdKey];
    [aCoder encodeObject:self.name forKey: kClientNameKey];
    [aCoder encodeObject:self.appMarker forKey: kClientAppMarkerKey];
    [aCoder encodeObject:self.signature forKey: kSignatureKey];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [self init]) {
        self.id = [aDecoder decodeObjectForKey: kIdKey];
        self.name = [aDecoder decodeObjectForKey: kClientNameKey];
        self.appMarker = [aDecoder decodeObjectForKey: kClientAppMarkerKey];
        self.signature = [aDecoder decodeObjectForKey: kSignatureKey];
    }
    return self;
}

@end
