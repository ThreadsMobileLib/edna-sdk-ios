//
//  Client.h
//  ThreadsApp
//
//  Created by Brooma Service on 27/10/2017.
//  Copyright © 2017 Brooma Service. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Client : NSObject

@property NSString* clientId;
@property NSString* name;
@property NSString* appMarker;

+ (instancetype) clientWithId: (NSString*) clientId name: (NSString*) name appMarker:(NSString*) appMarker;
+ (instancetype) initWithJson: (NSDictionary*) json;

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;

@end
