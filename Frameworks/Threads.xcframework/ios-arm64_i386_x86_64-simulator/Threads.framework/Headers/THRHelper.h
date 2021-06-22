//
//  THRHelper.h
//  Threads
//
//  Created by Tabriz Dzhavadov on 04/076/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THRMessage.h"

@class THRChat;
@class PushNotificationMessage;

@class PushNotificationMessage;
@protocol PushServerApiConfigDataSource;
@class EDNAPushLite;
@class EDNAPushLiteDelegate;
@class PushServerAPI;


@interface THRHelper : NSObject

@property (nonatomic, readonly) THRChat *chatModel;

+ (THRHelper *) sharedInstance;

- (BOOL) isOutgoingMessage:(THRMessage *)message;

- (BOOL) isLoadedMessage: (PushNotificationMessage *) message;

- (UIViewController *) topMostController;

- (NSString *)saveToTemporaryDirectoryImage:(UIImage *)image;

- (NSString *)pathToTemporaryImageWithName:(NSString *)name;

- (void) removeAllTemporaryImages;

- (NSString *) nameForImage:(UIImage *)image;

- (NSDictionary *) getFullEnviromentInfo;

- (NSDictionary *)getDeviceInfoWithProviderUid:(NSString *)providerUid deviceToken:(nullable NSData *)deviceToken;

- (nullable NSString *)getDeviceAddress;

- (NSData *)simulatedDeviceToken;

- (void)setDeviceAddress:(NSString *)deviceAddress;

+ (float) heightOfString: (NSString *) string font: (UIFont *) font width: (float) width;

+ (BOOL) hasDataStoreHistoryURL;

+ (NSString *) getHistoryUrl;

+ (NSString *) getDataStoreURL;

+ (NSURL*) getFileFullUrl: (NSURL *) fileUrl;

+ (NSURL*) getFileFullUrlFromString: (NSString *) fileUrl;

+ (NSString *) getFileFullUrlString: (NSString*) fileUrl;

- (NSString *)systemDeviceName;

- (NSString * _Nonnull) libVersion;

- (NSString *) appVersion;
@end
