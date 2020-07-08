//
//  THRPersistentStorage.h
//  Threads
//
//  Created by Denis Baluev on 14/07/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class THRMessage;

typedef void(^THRPersistentStorageGetMessagesCompletion)(NSArray<NSDictionary<NSString*, id>*> *messages, NSError *error);

@interface THRPersistentStorage : NSObject

#pragma mark - Folders

+ (NSString *) appDirectory;

+ (NSString *) thrDirectory;

+ (NSString *) clientDirectory;

+ (NSString *) directoryWithFolder: (NSString*) folder;

+ (NSString *) messagesDirectory;

+ (NSString *) imagesDirectory;

+ (NSString *) failedMessagesDirectory;

#pragma mark - Chat prefs

+ (void) saveChatState:(NSInteger)state;

+ (NSInteger) getChatState;

+ (void) saveClientId:(NSString *)clientId;

+ (NSString *) currentClientId;

+ (void) saveAppMarker:(NSString *)appMarker;

+ (NSString *)currentAppMarker;

+ (void) saveClientIdSignature:(NSString *) clientIdSignature;

+ (NSString*) currentClientIdSignature;

+ (void) saveClientName:(NSString *)name;

+ (NSString *) currentClientName;

+ (void) saveClientData:(NSString *)data;

+ (NSString *) currentClientData;

+ (void)resetClientForClientId:(NSString *)clientId;

+ (void) saveUuid:(NSString*) uuid forClientId:(NSString*) clientId;

+ (NSMutableDictionary *) getPreviousClientsUuids;

#pragma mark - Messages

+ (void) saveMessagesData: (NSDictionary *) data;

+ (void) getMessages: (THRPersistentStorageGetMessagesCompletion) completion;

#pragma mark - Failed Messages

+ (void) saveFailedMessage: (THRMessage *) message;

+ (void) removeFailedMessage: (THRMessage *) message;

+ (NSMutableDictionary *) getFailedMessages;
    
#pragma mark - Images

+ (UIImage *) getImageByName:(NSString *)imageName;

+ (NSString *) saveImage:(UIImage *)image withName:(NSString *)imageName;

+ (void) removeImageByName:(NSString *)imageName;

+ (void) remove;

#pragma mark - Helpers

+ (void) log;

@end
