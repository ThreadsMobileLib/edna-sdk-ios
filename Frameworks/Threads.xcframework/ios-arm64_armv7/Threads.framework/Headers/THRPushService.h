//
//  THRPushService.h
//  Threads
//
//  Created by Tabriz Dzhavadov on 30/06/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Threads.h"
#import "THRSpecialist.h"

NS_ASSUME_NONNULL_BEGIN

//@class PushNotificationMessage;
//@protocol PushServerApiConfigDataSource;
//@class EDNAPushLite;
//@class EDNAPushLiteDelegate;
//@class PushServerAPI;



static NSString * _Nonnull const THRForceSyncComplete = @"THRForceSyncComplete";




@class THRMessage;
@class THRChat;
@class THRSchedule;
@class THRSurvey;
@class TGMessageStatus;
@class THRJSQMediaItem;

typedef void(^THRMessageAttachmentCompletion)(NSString * _Nullable url, NSString * _Nullable state, NSError * _Nullable error);

typedef void(^THRRegistrationCompletion)(BOOL state, NSError * _Nullable error);

@interface THRPushService : NSObject

+ (instancetype)sharedInstance;

#pragma mark - Client Service State

- (void)sendInitChatWithCompletion:(nullable THRMessageSubmissionCompletion)completion;

- (void)sendClientInfoWithCompletion:(nullable THRMessageSubmissionCompletion)completion;

- (void)sendClientOfflineWithClientId:(NSString *)clientId completion:(nullable THRMessageSubmissionCompletion)completion;

#pragma mark - Client Message

- (void)sendTypingWithText:(NSString *)text completion:(nullable THRMessageSubmissionCompletion)completion;

- (void)sendMessage:(THRMessage *)message completion:(nullable THRMessageSubmissionCompletion)completion;

#pragma mark - Client Survey Interaction

- (void)completeSurvey:(THRSurvey *)survey completion:(nullable THRMessageSubmissionCompletion)completion;

- (void)removeSurvey:(THRSurvey *)survey;

#pragma mark - Old

+ (BOOL)isThreadsOriginPush:(NSDictionary *)push;

- (void)startForceSync;

- (void)stopForceSync;

- (void) cameShortPush: (NSDictionary *) push;

- (void) cameFullPush: (NSDictionary *) push;

- (void)didReceiveStatuses:(NSArray<TGMessageStatus *> *)statuses;

- (void) sendImage: (UIImage *) image
          fileName: (NSString *) fileName
        completion: (THRMessageAttachmentCompletion _Nonnull )completion;

- (void) sendAudioData: (NSData *) audioData
          fileName: (NSString *) fileName
            completion: (THRMessageAttachmentCompletion _Nonnull )completion;

- (void) sendFileData: (NSData *) audioData
          fileName: (NSString *) fileName
           completion: (THRMessageAttachmentCompletion)completion;

- (void) clearNotifications;

- (void) markMessagesAsReadByProviderId:(NSArray *) providerIds;

- (void) markMessagesAsReadByUuid: (NSArray *) uuids;

#pragma mark - Helpers

- (THRSpecialist *) getSpecilistFromPush: (NSDictionary *) push;

- (THRJSQMediaItem *) getMediaItemFromPush: (NSDictionary *) push;

- (THRJSQMediaItem *) getMediaItemFromPush: (NSDictionary *) push forSearch:(BOOL)forSearch;

- (THRMessage *) getQuotedMessageFromPush: (NSDictionary *) push;

- (THRMessage *) generateTHRMessageFromFullMessage: (NSDictionary *) push;

- (THRMessage * _Nullable)  generateTHRMessageFromInOutMessage: (id) object;

- (void) hasConnecttedSpecialist: (THRSpecialist *) spec;

- (NSString *) historySpecialist;

#pragma mark - EDNA

- (void) forceSync;

#pragma mark - Accessors

- (nullable NSString *) historyToken;

- (NSString *) deviceAddress;

- (NSString *) userAgent;

@end

NS_ASSUME_NONNULL_END
