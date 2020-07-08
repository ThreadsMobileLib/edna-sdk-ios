//
//  THRSpecialist.h
//  Threads
//
//  Created by Nikolay Kagala on 02/06/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "THRParticipant.h"

@interface THRSpecialist : THRParticipant

@property (copy, nonatomic, readonly) NSString* position;

@property (copy, nonatomic, readwrite) NSString* info;

@property (copy, nonatomic, readwrite) NSString* organizationUnit;

@property (copy, nonatomic, readwrite) NSString* alias;

- (instancetype) initWithIdentifier: (NSString*) identifier
                               name: (NSString*) name
                           position: (NSString*) position
                                sex: (THRParticipantSex) sex NS_DESIGNATED_INITIALIZER;

- (instancetype) initWithIdentifier: (NSString*) identifier NS_UNAVAILABLE;

- (instancetype) initWithIdentifier: (NSString*) identifier name: (NSString*) name NS_UNAVAILABLE;

- (instancetype) initWithIdentifier: (NSString*) identifier name: (NSString*) name sex:(THRParticipantSex)sex NS_UNAVAILABLE;

- (instancetype) initWithDict: (NSDictionary*) dict;

@end
