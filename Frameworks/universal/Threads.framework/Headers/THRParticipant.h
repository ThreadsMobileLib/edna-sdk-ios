//
//  THRParticipant.h
//  Threads
//
//  Created by Nikolay Kagala on 02/06/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "THRObject.h"
#import "JSQMessagesAvatarImage.h"

@class UIImage;

typedef NS_ENUM(NSUInteger, THRParticipantSex) {
    THRParticipantSexUnknown,
    THRParticipantSexFemale,
    THRParticipantSexMale
};

@interface THRParticipant : THRObject

@property (copy, nonatomic, readwrite) NSString* name;

@property (assign, nonatomic, readwrite) THRParticipantSex sex;

@property (strong, nonatomic, readwrite) NSURL* avatarURL;

@property (strong, nonatomic, readwrite) UIImage* image;

@property (nonatomic, readwrite) JSQMessagesAvatarImage *avatar;

+ (instancetype) unknown;

- (instancetype) initWithIdentifier: (NSString*) identifier
                               name: (NSString*) name
                                sex: (THRParticipantSex) sex NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithIdentifier:(NSString *)identifier NS_UNAVAILABLE;

- (void) getImage: (void(^)(BOOL state)) completion;

- (NSDictionary *)toDictionary;

- (NSString *)getDisplayName;

@end
